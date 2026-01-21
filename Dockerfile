
FROM ubuntu:24.04

WORKDIR /workdir

# TODO: there's a good reason to do all apt-get as one line
RUN apt-get update -y
RUN apt-get install -y curl
RUN apt-get install -y git
RUN apt-get install -y pip
RUN apt-get install -y tmux
RUN apt-get install -y gfortran
#RUN apt-get install -y npm

# Install nvim

# 0.12.0 has pack built in, and that is nightly as of 2025-08-07, not in the
# official release yet
RUN curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.tar.gz
#RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz

RUN tar -C /opt -xzf nvim-linux-x86_64.tar.gz
ENV PATH=$PATH:/opt/nvim-linux-x86_64/bin/
#RUN nvim --version

# pip can't run as root without "breaking" system packages
RUN pip install fortls  --break-system-packages   # install fortran lsp
RUN pip install pyright --break-system-packages  # install python lvp
#RUN npm i -g pyright
RUN fortls --version

# Install lua lsp
#
# TODO: try updating. Seems like there's a bad memory leak
RUN curl -LO https://github.com/LuaLS/lua-language-server/releases/download/3.13.9/lua-language-server-3.13.9-linux-x64.tar.gz
RUN tar xvf lua-language-server-3.13.9-linux-x64.tar.gz
RUN ln -s $PWD/bin/lua-language-server /usr/local/bin/lua-language-server
RUN lua-language-server --version

COPY . .
RUN ./install.sh

