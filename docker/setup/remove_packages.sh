#!/bin/sh

# Instead of building using docker layers, we just remove build-time packages using apt.
# This is possibly silly, but it is easier than having to hunt out which files are required from each layer

# Has to be run as admin

set -e

DEBIAN_FRONTEND=noninteractive apt-get remove -y \
    curl git nodejs npm unzip
