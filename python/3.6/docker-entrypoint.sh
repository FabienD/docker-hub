#!/bin/bash
set -e

cd /var/www

if [ -f "venv/bin/activate" ];
then
    echo "Virtualenv found and activated."
    source venv/bin/activate
fi

exec "$@"