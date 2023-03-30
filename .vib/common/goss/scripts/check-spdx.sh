#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

mapfile -t files < <( find /bitnami "$BITNAMI_ROOT_DIR" -name '.spdx-*.json' )

[[ ${#files[@]} -gt 0 ]]
