#!/bin/sh

USERNAME="${1:-docker}"

echo "[$(date)] Bootstrapping the container..."

clean_up() {
    # Perform program exit housekeeping

    echo "[$(date)] Stopping the Web server"
    service apache2 stop

    echo "[$(date)] Stopping FPM"
    service php-fpm stop

    echo "[$(date)] Exiting"
    exit
}

trap clean_up TERM

echo "[$(date)] Starting FPM..."
service php-fpm start

echo "[$(date)] Starting the Web server..."
service apache2 start

echo "[$(date)] Bootstrap finished"

tail -f /dev/null &
child=$!
wait "$child"
