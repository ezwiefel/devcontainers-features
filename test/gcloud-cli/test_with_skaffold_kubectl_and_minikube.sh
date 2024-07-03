#!/bin/bash -i

set -e

source dev-container-features-test-lib

# Check default tools installed
check "gcloud CLI exists" which gcloud
check "bq CLI exists" which bq
check "gsutil CLI exists" which gsutil

# Scenario specific
check "skaffold CLI exists" which skaffold
check "kubectl CLI exists" which kubectl
check "minikube CLI exists" which minikube

reportResults