#!/bin/sh

set -e

echo "Setting up the application..."

APP_DIR="$1"

cd "${APP_DIR}"

# @todo it would be nice to be able to run composer as www-data. Explore possibilities of su/sudo
composer install --optimize-autoloader --no-interaction
chown -R www-data:www-data vendor

# @todo we should move this block to composer.json
cd /tmp
curl -L -o jsxmlrpc.zip $(curl -s https://api.github.com/repos/gggeek/jsxmlrpc/releases/latest | grep "browser_download_url.*zip" | cut -d : -f 2,3 | tr -d \")
unzip jsxmlrpc.zip
mv jsxmlrpc-* jsxmlrpc
mkdir /var/www/html/debugger/jsxmlrpc
cp -R jsxmlrpc/lib /var/www/html/debugger/jsxmlrpc
cp -R jsxmlrpc/debugger /var/www/html/debugger/jsxmlrpc
chown -R www-data:www-data /var/www/html/debugger/jsxmlrpc
rm -rf jsxmlrpc*

echo "Done"
