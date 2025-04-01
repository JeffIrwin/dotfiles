
FROM ubuntu:22.04

WORKDIR /workdir

RUN apt-get update -y
RUN apt-get install -y pip       # needed to install fortls
RUN apt-get install -y curl      # needed to install nvim
RUN apt-get install -y git       # needed to bootstrap lazy.nvim
RUN apt-get install -y gfortran  # fortran compiler

# Install nvim

## nvim 0.11.0 doesn't display linted errors
#RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
RUN curl -LO https://github.com/neovim/neovim/releases/download/v0.10.4/nvim-linux-x86_64.tar.gz

RUN tar -C /opt -xzf nvim-linux-x86_64.tar.gz
ENV PATH=$PATH:/opt/nvim-linux-x86_64/bin/
#RUN nvim --version

# pip can't run as root without "breaking" system packages
#RUN pip install fortls  --break-system-packages   # install fortran lsp
RUN pip install fortls  # install fortran lsp
#RUN fortls --version

COPY . .
RUN ./install.sh

