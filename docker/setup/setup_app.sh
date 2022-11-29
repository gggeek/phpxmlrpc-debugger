#!/bin/sh

set -e

echo "Setting up the application..."

APP_DIR="$1"

cd "${APP_DIR}"

composer install --optimize-autoloader --no-interaction

chown -R www-data:www-data vendor

echo "Done"
