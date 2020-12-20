#!/bin/bash
set -e

cd /var/www

if [ -f "env/bin/activate" ];
then
    echo "Virtualenv found, use it now."
    source env/bin/activate
fi

exec "$@"