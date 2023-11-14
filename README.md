# flux-demo
If synced from Github, requires a fine grained access token with the following permissions.

| Permission type | Access type  |
| --------------- | ------------ |
| Administration  | Read & Write |
| Contents        | Read & Write |
| Metadata        | Read         |


## Getting started
This project uses Visual Studio Code and Dev Containers. Make sure to execute _build and reopen in container_ from the command palette. 
1. Create your cluster, or use minikube by executing `minikube start`.
2. Bootstrap [flux](https://fluxcd.io/flux/installation/). 

    ```bash
    flux bootstrap github \
    --token-auth \
    --owner=$GITHUB_USER \
    --repository=flux-demo \
    --branch=main \
    --path=clusters/main \
    --personal
3. Wait for reconciliation.
4. Expose/Port forward services if running minikube. 
   1) GitOps Weave from flux-system namespace on port 9001. Creds are admin/admin. For helm values documentation, refer to https://docs.gitops.weave.works/docs/references/helm-reference/. 
   2) Kubernetes dashboard from kubernetes-dashboard namespace on port 9090.
