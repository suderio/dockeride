#!/bin/sh

# git config
if [ ! -z "$GIT_USER_NAME" ] && [ ! -z "$GIT_USER_EMAIL" ]; then
  git config --global user.name "$GIT_USER_NAME"
  git config --global user.email "$GIT_USER_EMAIL"
fi

# user 'idev' config
USER_ID=${HOST_USER_ID:-9001}
GROUP_ID=${HOST_GROUP_ID:-9001}

if [ ! -z "$USER_ID" ] && [ "(id -u idev)" != "$USER_ID" ]; then
  groupadd --non-unique -g "$GROUP_ID" group
  usermod --non-unique --uid "$USER_ID" --gid "$GROUP_ID" idev
fi

chown -R idev: /home/idev
chown idev: /var/run/docker.sock

exec /sbin/su-exec idev tmux -u -2 "$@"

