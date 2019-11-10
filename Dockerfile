# docker run -it --rm -v /path/to/host/workspace:/workspace \
# -v /var/run/docker/sock:/var/run/docker.sock \
# -v ~/.ssh:/home/idev/.ssh \
# -e HOST_USER_ID=$(id -u $USER) -e HOST_GROUP_ID=$(id -g $USER) \
# -e GIT_USER_NAME="Your Name Here" -e GIT_USER_EMAIL="your@email.com" \
# dockeride:latest

FROM debian:buster-slim
LABEL MAINTAINER="Paulo Suderio <paulo.suderio@gmail.com>"
LABEL DESCRIPTION="Ambiente de desenvolvimento com neovim e emacs"

#Locale
RUN apt-get update && apt-get install -y locales \
    && localedef -i pt_BR -c -f UTF-8 -A /usr/share/locale/locale.alias pt_BR.UTF-8
ENV LANG pt_BR.utf8
ENV LANGUAGE pt_BR:pt:en_US:en
ENV LC_ALL pt_BR.UTF-8
RUN echo 'LANG=pt_BR.UTF-8' >> /etc/locale.conf
RUN echo 'KEYMAP=br-abnt2' >> /etc/vconsole.conf

RUN cat /etc/apt/sources.list
# Configure proxy
ARG proxy
ENV HTTP_PROXY=$proxy HTTPS_PROXY=$proxy NO_PROXY=$no_proxy http_proxy=$proxy https_proxy=$proxy no_proxy=localhost,127.0.0.1

# Base install
RUN apt-get install -y neovim git zsh tmux openssh-client curl docker-compose emacs-nox \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | zsh 

# Create the user
RUN useradd -ms /bin/zsh idev
WORKDIR /home/idev
ENV HOME /home/idev

# Configure dotfiles 
COPY zshrc .zshrc
COPY init.vim .config/nvim/init.vim
COPY tmux.conf .tmux.conf
COPY bashrc .bashrc
COPY profile .profile
COPY spacemacs .spacemacs
COPY inputrc .inputrc
COPY gitconfig .gitconfig
COPY aliases.sh bin/aliases.sh

# Install emacs / neovim plugins
RUN git clone https://github.com/syl20bnr/spacemacs .emacs.d
RUN curl -fLo .local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN nvim +PlugInstall +qall >> /dev/null

# Install tmux plugins
RUN git clone https://github.com/tmux-plugins/tpm .tmux/plugins/tpm
RUN .tmux/plugins/tpm/bin/install_plugins

# Entrypoint script
COPY entrypoint.sh /bin/entrypoint.sh
WORKDIR /workspace
CMD ["/bin/entrypoint.sh"]

