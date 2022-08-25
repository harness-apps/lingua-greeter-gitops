#!/usr/bin/env bash

set -euxo pipefail

docker network create "${DOCKER_NETWORK_NAME}" || true

drone exec --trusted --network="${DOCKER_NETWORK_NAME}"

mkdir -p "${APP_GITOPS_HOME}/.kube"

k3d kubeconfig get "${K3D_CLUSTER_NAME}" > "${KUBECONFIG}"
sed -i 's|host.docker.internal|127.0.0.1|' "${KUBECONFIG}"