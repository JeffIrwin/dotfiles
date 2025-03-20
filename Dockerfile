
FROM ubuntu:24.04

WORKDIR /workdir

RUN apt update -y
RUN apt install -y curl
RUN apt install -y git
RUN apt install -y pip
#RUN apt install -y npm

# Install nvim
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
RUN tar -C /opt -xzf nvim-linux-x86_64.tar.gz
ENV PATH=$PATH:/opt/nvim-linux-x86_64/bin/
#RUN nvim --version

# pip can't run as root without "breaking" system packages
RUN pip install fortls --break-system-packages   # install fortran lsp
RUN pip install pyright --break-system-packages  # install python lvp
#RUN npm i -g pyright
RUN fortls --version

# Install lua lsp
RUN curl -LO https://github.com/LuaLS/lua-language-server/releases/download/3.13.9/lua-language-server-3.13.9-linux-x64.tar.gz
RUN tar xvf lua-language-server-3.13.9-linux-x64.tar.gz
RUN ln -s $PWD/bin/lua-language-server /usr/local/bin/lua-language-server
RUN lua-language-server --version

COPY . .
RUN ./install.sh

# TODO: move this to install.sh
RUN nvim --headless "+Lazy! sync" +qa

