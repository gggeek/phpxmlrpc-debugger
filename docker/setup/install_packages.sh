#!/bin/sh

# Has to be run as admin

set -e

echo "Installing base software packages..."

DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl git lsb-release sudo unzip

echo "Done installing base software packages"
