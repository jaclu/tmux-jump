#!/usr/bin/env bash

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# shellcheck source=scripts/utils.sh
source "$current_dir"/utils.sh

JUMP_BACKGROUND_COLOR=$(get_tmux_option "@jump-bg-color" "\e[0m\e[32m")
JUMP_FOREGROUND_COLOR=$(get_tmux_option "@jump-fg-color" "\e[1m\e[31m")
JUMP_KEYS_POSITION=$(get_tmux_option "@jump-keys-position" "left")
export JUMP_BACKGROUND_COLOR JUMP_FOREGROUND_COLOR JUMP_KEYS_POSITION

tmp_file="$(mktemp)"
$TMUX_BIN command-prompt -1 -p 'char:' "run-shell \"printf '%1' >> $tmp_file\""

ruby "$current_dir/tmux-jump.rb" "$tmp_file"
