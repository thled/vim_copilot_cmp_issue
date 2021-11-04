FROM alpine:3.14 as tools

# install dependencies
RUN apk add --no-cache \
    git \
    build-base \
    cmake \
    automake \
    autoconf \
    libtool \
    pkgconf \
    coreutils \
    curl \
    unzip \
    gettext-tiny-dev \
    musl-dev

WORKDIR /tools

RUN \
    # build neovim
    cd /tools \
    && git clone https://github.com/neovim/neovim.git \
    && cd neovim \
    && make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=/tools/nvim install \
    # fetch plugin manager
    && cd /tools \
    && curl -fLo /tools/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

FROM alpine:3.14

# install dependencies
RUN apk add --no-cache \
    musl-dev \
    g++ \
    curl \
    git \
    nodejs 

# add neovim
COPY --from=tools /tools/nvim /nvim
RUN ln -s /nvim/bin/nvim /usr/bin/nvim

# add user
RUN adduser -D neovim
USER neovim

# add config
COPY --chown=neovim:neovim config /home/neovim/.config

# add plugin manager
COPY --chown=neovim:neovim --from=tools /tools/plug.vim /home/neovim/.config/nvim/autoload/

# install plugins
RUN nvim --headless +PlugInstall +qall

WORKDIR /data

ENTRYPOINT [ "nvim", "."]

