#!/bin/sh

# remove files to make the image small

rm -rf /root/.cache/composer/

apt-get clean
