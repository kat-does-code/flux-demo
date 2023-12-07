locals {
  kube_config_location = "~/.kube/config"
  kube_context = "minikube"
}

terraform {
  required_version = ">= 0.12"

  required_providers {
    flux = {
      source = "fluxcd/flux"
      version = "1.1.2"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.24.0"
    }
  }
}

provider "kubernetes" {
  config_path    = local.kube_config_location
  config_context = local.kube_context
}


provider "flux" {
  kubernetes = {
    config_path = local.kube_config_location
    config_context = local.kube_context
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
}
