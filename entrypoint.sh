#!/bin/bash

USER_ID=${LOCAL_USER_ID:-9001}

useradd --shell /bin/bash -u $USER_ID -o -c "" -m user

export HOME=/devpython

printf '%s\n\t%s\n\t%s\n' '[user]' 'email = ci@dummyuser.ci.inria.fr' 'name = CI' >> /home/user/.gitconfig

exec /usr/local/bin/gosu user "$@"
