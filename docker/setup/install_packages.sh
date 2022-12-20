#!/bin/sh

# Has to be run as admin

set -e

echo "Installing base software packages..."

DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl git nodejs npm sudo unzip

echo "Done installing base software packages"
