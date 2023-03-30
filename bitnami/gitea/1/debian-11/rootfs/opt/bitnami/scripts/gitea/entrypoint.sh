#!/bin/bash

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace # Uncomment this line for debugging purposes

# Load libraries
. /opt/bitnami/scripts/libbitnami.sh
. /opt/bitnami/scripts/liblog.sh
. /opt/bitnami/scripts/libos.sh

# Load Gitea environment variables
. /opt/bitnami/scripts/gitea-env.sh

print_welcome_page

# Configure libnss_wrapper based on the UID/GID used to run the container
# This container supports arbitrary UIDs, therefore we have do it dynamically
if ! am_i_root; then
    export LNAME="gitea"
    export LD_PRELOAD="/opt/bitnami/common/lib/libnss_wrapper.so"
    if [[ -f "$LD_PRELOAD" ]]; then
        info "Configuring libnss_wrapper"
        NSS_WRAPPER_PASSWD="$(mktemp)"
        export NSS_WRAPPER_PASSWD
        NSS_WRAPPER_GROUP="$(mktemp)"
        export NSS_WRAPPER_GROUP
        echo "gitea:x:$(id -u):$(id -g):gitea:/opt/bitnami/gitea:/bin/false" >"$NSS_WRAPPER_PASSWD"
        echo "gitea:x:$(id -g):" >"$NSS_WRAPPER_GROUP"
        chmod 400 "$NSS_WRAPPER_PASSWD" "$NSS_WRAPPER_GROUP"
    fi
fi

if [[ "$1" = "/opt/bitnami/scripts/gitea/run.sh" ]]; then
    info "** Starting Gitea setup **"
    /opt/bitnami/scripts/gitea/setup.sh
    info "** Gitea setup finished! **"
fi

echo ""
exec "$@"
