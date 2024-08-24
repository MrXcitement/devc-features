#!/bin/bash

set -e


# shellcheck disable=SC1091
source dev-container-features-test-lib

# Installation folders
PREFIX=/usr/local
BINDIR="$PREFIX/bin"
DATADIR="$PREFIX/share"

# Validate the exercism cli was installed
check "exercism bin location" bash -c "ls $BINDIR/exercism"
check "version" bash -c "exercism version | grep '3\.4\.2'"

# Validate the exercism completion files were installed.
check "exercism completion files installed" bash -c "ls "$DATADIR/exercism""

reportResults
