#!/usr/bin/env bash
#
# Install the Exercism CLI tool
# https://github.com/exercism/cli
#
# Dependencies: curl, cut
#
# Environment:
#   - VERSION: The version to install [default: latest].

set -e

apt_get_update()
{
    if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
        echo "Running apt-get update..."
        apt-get update -y
    fi
}

# Checks if packages are installed and installs them if not
check_packages() {
    if ! dpkg -s "$@" > /dev/null 2>&1; then
        apt_get_update
        apt-get -y install --no-install-recommends "$@"
    fi
}

# Exercism github repo and latest release
GITHUB_BASE_URL="https://github.com/exercism/cli"
LATEST_URL="${GITHUB_BASE_URL}/releases/latest/"

# Install locations
PREFIX="/usr/local"
BINDIR="${PREFIX}/bin"
DATADIR="${PREFIX}/share"

# Get the current operating system name and id
# shellcheck disable=SC1091
OS_NAME=$(. /etc/os-release; echo "$NAME")
# shellcheck disable=SC1091
OS_ID=$(. /etc/os-release; echo "$ID")

# Validate the current operating system
if [ "$OS_ID" != "debian" ] && [ "$OS_ID" != "ubuntu" ]; then
    echo "(!) Unknown operating system image $OS_NAME."
    echo "To resolve, choose a compatible operating system image: Debian or Ubuntu"
    exit 1
fi

# Get the current operating system's distribution codename
# shellcheck disable=SC1091
OS_CODENAME=$(. /etc/os-release; echo "$VERSION_CODENAME")

# Validate we have a codename
SUPPORTED_CODENAMES="bullseye bookworm focal jammy noble"
if [ -z "$OS_CODENAME" ]; then
    echo "(!) Unknown distribution version."
    echo "To resolve, choose a compatible OS and distribution: ${SUPPORTED_CODENAMES}"
    exit 1
fi

# Validate the codename is valid
if [[ "${SUPPORTED_CODENAMES}" != *"${OS_CODENAME}"* ]]; then
    echo "(!) Unsupported distribution version: '${OS_CODENAME}'."
    echo "To resolve, choose a compatible OS and distribution: ${SUPPORTED_CODENAMES}"
    exit 1
fi

# Get the current architecture.
ARCH="$(dpkg --print-architecture)"

# Validate the architecture
SUPPORTED_ARCHITECTURES="amd64 arm64"
if [[ "${SUPPORTED_ARCHITECTURES}" != *"${ARCH}"* ]]; then
    echo "(!) Unsuported architecture: ${ARCH}."
    echo "To resolve, choose to run on a supported architecture: ${SUPPORTED_ARCHITECTURES}"
    exit 1
fi

export DEBIAN_FRONTEND=noninteractive
check_packages curl ca-certificates

# Get the latest version of the exercism cli
if [[ -z "$VERSION" ]] || [[ "$VERSION" = "latest" ]]; then {
    VERSION=$(curl -sLI -o /dev/null -w '%{url_effective}' "$LATEST_URL" | cut -d "v" -f 2)
} fi

# Map the current architecture to download architecture
RELEASE_ARCH=$ARCH
[[ "$ARCH" == "amd64" ]] && RELEASE_ARCH="x86_64"

# The location of the exercism release to download
RELEASE_URL="${GITHUB_BASE_URL}/releases/download/v${VERSION}/exercism-${VERSION}-linux-${RELEASE_ARCH}.tar.gz"

# A temporary download directory
DOWNLOAD_DIR=$(mktemp -d || mktemp -d -t 'tmp')

pushd "$DOWNLOAD_DIR"
curl -sL --retry 3 "$RELEASE_URL" | tar -xz

echo "Installing exercism v${VERSION} to ${BINDIR}"
install -v exercism "$BINDIR"

# Install completion files to the exercism datadir
echo "Installing completion files to ${DATADIR}/exercism"
mkdir -p "${DATADIR}/exercism"
cp -v shell/* "${DATADIR}/exercism"

popd

echo "Remove $DOWNLOAD_DIR"
rm -r "$DOWNLOAD_DIR"
