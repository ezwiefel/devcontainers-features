#!/usr/bin/env bash
# Install the gcloud CLI along with any specified components
# Based on https://github.com/devcontainers-contrib/features/blob/9a1d24b27b2d1ea8916ebe49c9ce674375dced27/src/apt-get-packages/install.sh

set -e

source ./library_scripts.sh

# nanolayer is a cli utility which keeps container layers as small as possible
# source code: https://github.com/devcontainers-contrib/nanolayer
# `ensure_nanolayer` is a bash function that will find any existing nanolayer installations, 
# and if missing - will download a temporary copy that automatically get deleted at the end 
# of the script
ensure_nanolayer nanolayer_location "v0.5.6"


_GCLOUD_PACKAGE_NAME=$(if [[ -n $VERSION ]] || [[ $VERSION == "latest" ]]; then echo "google-cloud-cli" ; else echo "google-cloud-cli=${VERSION}" ; fi)

APT_INSTALL_LIST=$(if [[ -n $ADDITIONAL_COMPONENTS ]]; then echo "${_GCLOUD_PACKAGE_NAME}, ${ADDITIONAL_COMPONENTS}"; else echo "${_GCLOUD_PACKAGE_NAME}"; fi)

# gcloud cli installation requires apt-transport-https, ca-certificates, gnupg, and curl
$nanolayer_location install apt-get "apt-transport-https,ca-certificates, gnupg, curl"

# Add packages.cloud.google.com to apt repositories
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

$nanolayer_location install apt-get "${APT_INSTALL_LIST}"
