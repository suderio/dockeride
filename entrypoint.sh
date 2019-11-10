#!/bin/sh

# git config
if [ ! -z "$GIT_USER_NAME" ] && [ ! -z "$GIT_USER_EMAIL" ]; then
  git config --global user.name "$GIT_USER_NAME"
  git config --global user.email "$GIT_USER_EMAIL"
fi

# user 'idev' config
USER_ID=${HOST_USER_ID:-9001}
GROUP_ID=${HOST_GROUP_ID:-9001}

echo "user: $USER_ID, group: $GROUP_ID"

if [ ! -z "$USER_ID" ] && [ "(id -u idev)" != "$USER_ID" ]; then
  groupadd --non-unique -g "$GROUP_ID" idev
  usermod --non-unique --uid "$USER_ID" --gid "$GROUP_ID" idev
fi

chown -R idev: /home/idev
chown idev: /var/run/docker.sock

runuser -u idev zsh "$@"

