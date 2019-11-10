# Dockeride

Um ambiente de desenvolvimento usando _neovim_, _spacemacs_ e _tmux_

## Build

O build pode ser feito passando a variável `proxy` para configuração de um proxy local.

## Run

```bash
docker run -it --rm -v /path/to/host/workspace:/workspace \
-v /var/run/docker/sock:/var/run/docker.sock \
-v ~/.ssh:/home/idev/.ssh \
-e HOST_USER_ID=$(id -u $USER) -e HOST_GROUP_ID=$(id -g $USER) \
-e GIT_USER_NAME="Your Name Here" -e GIT_USER_EMAIL="your@email.com" \
dockeride:latest
```


