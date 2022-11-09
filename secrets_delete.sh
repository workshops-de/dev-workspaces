#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

. ${SCRIPT_DIR}/script_init.inc.sh

gcloud secrets delete ${CLUSTER_NAME}_app_config --project ${GCLOUD_PROJECT} --quiet 2> /dev/null || true

echo ok.