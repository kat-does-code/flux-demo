# flux-demo
If synced from Github, requires a fine grained access token with the following permissions.

| Permission type | Access type  |
| --------------- | ------------ |
| Administration  | Read & Write |
| Contents        | Read & Write |
| Metadata        | Read         |

## Weave GitOps
Helm values docs: https://docs.gitops.weave.works/docs/references/helm-reference/

## Setup
1. Create your cluster, or use minikube 
2. Bootstrap flux.

  ```flux bootstrap github \
  --token-auth \
  --owner=$GITHUB_USER \
  --repository=flux-demo \
  --branch=main \
  --path=clusters/main \
  --personal```