#!/bin/bash
set -e

cd /var/www

if [ -f "venv/bin/activate" ];
then
    echo "Virtualenv found and activated."
    source venv/bin/activate
fi

if [ -f "/run/secrets/pgp_public_key" ];
then
    export PGP_PUBLIC_KEY=`cat /run/secrets/pgp_public_key`
fi

if [ -f "/run/secrets/pgp_private_key" ];
then
    export PGP_PRIVATE_KEY=`cat /run/secrets/pgp_private_key`
fi

exec "$@"