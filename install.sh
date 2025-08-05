#!/bin/sh

PACK_DIR="$HOME/.config/nvim/pack/devfiles/start"
PLUGIN_URLS='
https://github.com/tylerbrazier/devfiles.git
https://github.com/tylerbrazier/vim-forgit.git
https://github.com/neovim/nvim-lspconfig.git
https://github.com/lewis6991/gitsigns.nvim.git
'

set -x

mkdir -p "$PACK_DIR"
cd "$PACK_DIR" || exit

echo "$PLUGIN_URLS" | xargs -t -L 1 git clone

nvim --headless -u NORC -c 'helptags ALL' -c q

npm install -g typescript typescript-language-server
