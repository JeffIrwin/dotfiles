
FROM ubuntu:24.04

RUN apt update -y
RUN apt install -y curl
RUN apt install -y git
RUN apt install -y pip
#RUN apt install -y npm

WORKDIR /workdir

RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
RUN tar -C /opt -xzf nvim-linux-x86_64.tar.gz
ENV PATH=$PATH:/opt/nvim-linux-x86_64/bin/
#RUN nvim --version

RUN pip install fortls --break-system-packages
RUN pip install pyright --break-system-packages
#RUN npm i -g pyright
RUN fortls --version

RUN curl -LO https://github.com/LuaLS/lua-language-server/releases/download/3.13.9/lua-language-server-3.13.9-linux-x64.tar.gz
RUN tar xvf lua-language-server-3.13.9-linux-x64.tar.gz
RUN ln -s $PWD/bin/lua-language-server /usr/local/bin/lua-language-server
RUN lua-language-server --version

COPY . .
RUN ./install.sh

## Done automatically via git in lua
#RUN git clone https://github.com/neovim/nvim-lspconfig ~/.config/nvim/pack/nvim/start/nvim-lspconfig

RUN nvim --headless "+Lazy! sync" +qa

