terraform {
  required_version = ">= 0.12"

  required_providers {
    minikube = {
      source = "scott-the-programmer/minikube"
      version = "0.3.6"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.12.1"
    }
    flux = {
      source = "fluxcd/flux"
      version = "1.1.2"
    }
  }
}

provider "minikube" {
  kubernetes_version = "v1.28.3"
}

resource "minikube_cluster" "docker" {
  driver = "docker"
  cluster_name = "terraform-minikube-in-docker"
  cni = "calico"
  addons = [
    "default-storageclass",
    "storage-provisioner",
    "dashboard"
  ]
}

provider "kubernetes" {
  host = minikube_cluster.docker.host

  client_certificate = minikube_cluster.docker.client_certificate
  client_key = minikube_cluster.docker.client_key
  cluster_ca_certificate = minikube_cluster.docker.cluster_ca_certificate
}

provider "flux" {
  kubernetes = {
    host = minikube_cluster.docker.host

    client_certificate = minikube_cluster.docker.client_certificate
    client_key = minikube_cluster.docker.client_key
    cluster_ca_certificate = minikube_cluster.docker.cluster_ca_certificate
  }
  git = {
    url = "https://github.com/kat-does-code/flux-demo.git"
    http = {
      allow_insecure_http = false
      username = "flux"
      password = var.github_pat
    }
  }
}

resource "flux_bootstrap_git" "this" {
  path = "clusters/main"

  lifecycle {
    replace_triggered_by = [ minikube_cluster.docker.id ]
  }
}
