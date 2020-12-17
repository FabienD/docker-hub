#!/bin/bash
set -e

cd /var/www

if [ -f "env/bin/activate" ];
then
    echo "Virtualenv found, use it now."
    source env/bin/activate
fi

echo 'export PS1="| 🐍 ${PYTHON_VERSION} | \[\033[1;36m\]\h \[\033[1;34m\]\W\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]"' >> .bashrc

exec "$@"