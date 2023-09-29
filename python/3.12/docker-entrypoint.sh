#!/bin/bash
set -e

cd /var/www

# Try to find and activate a virtualenv
venv_names=(".venv" "venv" ".virtualenv" "virtualenv")

for name in ${venv_names[@]}; do
    if [ -f "$name/bin/activate" ];
    then
        echo "Virtualenv found in $name. Let's activate it."
        source $name/bin/activate
        break
    fi
done

# PGP env keys are set from Docker secrets
if [ -f "/run/secrets/pgp_public_key" ];
then
    export PGP_PUBLIC_KEY=`cat /run/secrets/pgp_public_key`
fi

if [ -f "/run/secrets/pgp_private_key" ];
then
    export PGP_PRIVATE_KEY=`cat /run/secrets/pgp_private_key`
fi

exec "$@"