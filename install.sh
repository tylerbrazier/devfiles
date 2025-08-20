#!/bin/sh

pack_dir="$HOME/.config/nvim/pack/devfiles/start"
plugin_urls='
https://github.com/tylerbrazier/devfiles.git
https://github.com/tylerbrazier/vim-forgit.git
https://github.com/neovim/nvim-lspconfig.git
https://github.com/lewis6991/gitsigns.nvim.git
'
add_to_shrc='
. ~/.git-prompt.sh
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
'
shell=

case "$SHELL" in
	*bash)
		shell=bash
		add_to_shrc=". ~/.git-completion.bash${add_to_shrc}"
		add_to_shrc="${add_to_shrc}PROMPT_COMMAND='__git_ps1 \"\\w \" \"\\$ \" \"%s \"'"
		;;
	*zsh)
		shell=zsh
		add_to_shrc="${add_to_shrc}precmd() { __git_ps1 '%~ ' '%# ' '%s ' }"
		;;
	*)
		echo "Unsupported shell: $SHELL" >&2
		exit 1
esac

set -x

mkdir -p "$pack_dir"
cd "$pack_dir" || exit

echo "$plugin_urls" | xargs -t -L 1 git clone

nvim --headless -u NORC -c 'helptags ALL' -c q

npm install -g typescript typescript-language-server

curl -o "$HOME/.git-prompt.sh" \
	https://raw.githubusercontent.com/git/git/refs/heads/master/contrib/completion/git-prompt.sh

[ "$shell" = "bash" ] && curl -o "$HOME/.git-completion.bash" \
	https://raw.githubusercontent.com/git/git/refs/heads/master/contrib/completion/git-completion.bash

echo "$add_to_shrc" >> "$HOME/.${shell}rc"
${EDITOR:-vi} "$HOME/.${shell}rc"
