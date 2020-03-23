FROM golang:1.13

ARG CONTAINER_GID
ARG CONTAINER_UID
ARG CONTAINER_USER=hugo
RUN \
    # Add user
    adduser --disabled-password --gecos '' $CONTAINER_USER && \
    groupmod -g $CONTAINER_GID $CONTAINER_USER && \
    usermod -u $CONTAINER_UID -g $CONTAINER_GID $CONTAINER_USER && \
    # Install node.js
    apt-get install -yqq gnupg > /dev/null && \
    curl -sL https://deb.nodesource.com/setup_12.x | bash > /dev/null && \
    apt-get install -yqq nodejs autoconf libtool nasm > /dev/null && \
    # Install dependencies for "introduction" theme
    npm install -g postcss-cli && \
    npm install -g autoprefixer

USER $CONTAINER_USER
RUN \
    # Install hugo
    mkdir $HOME/src && \
    cd $HOME/src && \
    git clone https://github.com/gohugoio/hugo.git && \
    cd hugo && \
    go install --tags extended
