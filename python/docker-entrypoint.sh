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

exec "$@"