# Developer Workspaces

This repository conains the GitHub Actions to spawn a development environment, that can be used as a learning environment.

## Usage from the trainer perspective

*Note: every secret and other config data of a workspace is stored in a single secret in the Google Secret Manager, which is named `'cluster_name'_app_config`.
Take a look at: https://console.cloud.google.com/security/secret-manager?organizationId=149269172422&project=spaces-workshops-de*

1. Start a Workspace with the `run` GitHub Action: https://github.com/workshops-de/dev-workspaces/actions/workflows/run.yml (it takes about 25 minutes)
2. Visit the URL of the workspace: https://coder.`cluster_name`.spaces.workshops.de
3. Login with the coder admin credentials for administration purposes. (`coder_admin_email`/ `coder_admin_password`)
4. The participants (including you) can register themselfs with email verification via OpenID Connect to get a developer account.
5. After the workshop call the `destroy` Action: https://github.com/workshops-de/dev-workspaces/actions/workflows/destroy.yml to tear down the workspace (this takes about 15 minutes).

## Workspaces

### cnative: Docker/Kubernetes

The first use case at workshops.de is the Docker/Kubernetes workshop.

- URL: https://coder.cnative.spaces.workshops.de
- Container Image with all the needed tools (docker, kubectl, helm, ...): https://github.com/klauserber/docker-k8s-training-image

**Admin hint**: The `kubeconfig` file of the admins development container, located at `/home/coder/.kube/config` has full cluster admin rights in the underlying Kubernetes cluster.

## Useful links:

- https://keycloak.`cluster_name`.spaces.workshops.de ( *admin* / `keycloak_admin_password` )

  We are using Keycloak as OpenID Connect provider. The admin user is used to manage the users. As an Admin you can also create new users or skip the email verification.

- https://keycloak.`cluster_name`.spaces.workshops.de/realms/workshops-de/account

  This is the location where users kann manage their account. They can change or recover their password add second factor authentication etc.

- https://grafana.`cluster_name`.spaces.workshops.de - System monitoring ( *admin* / `grafana_password` )

## Other Facts

- We have cluster autoscaling enabled, so the cluster will scale up and down automatically. The developer environments will switched off automatically after a configured time (`max_ttl`) if the are idle (not working yet but with next release of coder: https://github.com/coder/coder/pull/4843). They can be restarted by the user at anytime. But it is a good practice to encourage the user to keep their environments stopped if they are not needed.

- Every system- und user data is backuped continiuesly. The backups are stored in a Google Cloud Storage Bucket. The backups are encrypted with end-to-end encryption. The data will be automaticly restored on cluster recreation. Currently we have to manually delete the data for a workspace to get a completely new environment, this will be automated soon.

## How it works

Technically everythings is running in containers orchestrated by Kubernetes in the Google cloud.

Visit this page for more technical details: https://github.com/klauserber/coder-development-cluster