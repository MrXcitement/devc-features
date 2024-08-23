#!/bin/bash

# This test file will be executed against an auto-generated devcontainer.json that
# includes the 'color' Feature with no options.
#
# For more information, see: https://github.com/devcontainers/cli/blob/main/docs/features/test.md
#
# Eg:
# {
#    "image": "<..some-base-image...>",
#    "features": {
#      "color": {}
#    },
#    "remoteUser": "root"
# }
#
# Thus, the value of all options will fall back to the default value in the
# Feature's 'devcontainer-feature.json'.
# For the 'color' feature, that means the default favorite color is 'red'.
#
# These scripts are run as 'root' by default. Although that can be changed
# with the '--remote-user' flag.
#
# This test can be run with the following command:
#
#    devcontainer features test    \
#               --features color   \
#               --remote-user root \
#               --skip-scenarios   \
#               --base-image mcr.microsoft.com/devcontainers/base:ubuntu \
#               /path/to/this/repo

set -e

# shellcheck disable=SC1091
source dev-container-features-test-lib

PREFIX=/usr/local
BINDIR="$PREFIX/bin"
DATADIR="$PREFIX/share"

# Validate the exercism cli was installed
check "exercism bin location" bash -c "ls $BINDIR/exercism"
check "version" bash -c "exercism version"

# Validate the exercism completion files were installed.
check "exercism completion files installed" bash -c "ls "$DATADIR/exercism""

reportResults
