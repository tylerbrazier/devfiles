#!/bin/sh

pack_dir="$HOME/.config/nvim/pack/devfiles/start"
plugin_urls='
https://github.com/tylerbrazier/devfiles.git
https://github.com/tylerbrazier/vim-forgit.git
https://github.com/neovim/nvim-lspconfig.git
https://github.com/lewis6991/gitsigns.nvim.git
'

set -x

mkdir -p "$pack_dir"
cd "$pack_dir" || exit

echo "$plugin_urls" | xargs -t -L 1 git clone

nvim --headless -u NORC -c 'helptags ALL' -c q

npm install -g typescript typescript-language-server
