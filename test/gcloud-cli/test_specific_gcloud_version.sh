#!/bin/bash -i

set -e

source dev-container-features-test-lib

# Check default tools installed
check "gcloud_exists" which gcloud
check "bq_exists" which bq
check "gsutil" which gsutil

# Scenario specific
check "gcloud_version" gcloud --version | grep "${VERSION}"

reportResults