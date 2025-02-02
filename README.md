# Tmux-Jump

<p align="center">
  <img src="assets/tmux-jump-logo.png"
       alt="Vimium/Easymotion like cursor jump for tmux."
       title="tmux-jump" />
</p>

[![Build Status](https://travis-ci.org/schasse/tmux-jump.svg?branch=master)](https://travis-ci.org/schasse/tmux-jump)

## Changes in this Fork

### Made searches case-sensitive

Converting searches and screen content to lower-case just ends up giving
to many false positives.

### Dependency

Minimum tmux version is now listed as 2.4 instead of 3.1, after being able
to test compatibility in various tmux versions

### Uses a bind note if tmux >= 3.1

If the used tmux supports it, a -N note is used when binding the trigger.
This makes this key bind be listed when listing or searching for keys
with notes, such as `<prefix>-?`

### Multiple tmux versions usage

Instead of using the command `tmux` directly `$TMUX_BIN` is used,
to allow running an inner tmux server with a different version of tmux.
A necessity when experimenting with backwards compatibility of plugins etc.

If TMUX_BIN is not defined it will be set to `tmux` so this should be usable
also when the TMUX_BIN env variable is not defined.

### Linted the project

Corrected syntactical glitches and a few typos.

## The rest of this README is unchanged

A fast way to jump wherever you want in your terminal without using the mouse.
A plugin similar to [vimium](https://vimium.github.io/) and
[easymotion](https://github.com/easymotion/vim-easymotion) but for tmux.
tmux-jump is written in ruby and can easily be installed via tpm.

![tmux-jump-demo](https://user-images.githubusercontent.com/3882305/74186577-2f6aad80-4c4b-11ea-8054-91c54e3dd2af.gif)

From now to then I think about how to improve my dev tools.
Copy and pasting inside the terminal is something I do everyday, all the time.
This is one of the most obvious things make more efficient.
[tmux-yank](https://github.com/tmux-plugins/tmux-yank) improved the situation a lot.
Though, it felt still annoying to get to the string I wanted to copy.
Either I used to enter tmux copy mode and moved the cursor to the string or I used the mouse.
I looked for a plugin such as easymotion for vim or ace jump for emacs,
but I couldn't find one. So I decided to write my own tmux plugin.

## Requirements

* [tmux](https://github.com/tmux/tmux) >= 2.4
* [ruby](https://www.ruby-lang.org/) >= 2.3

## Installation via [TPM](https://github.com/tmux-plugins/tpm)

Add plugin to the list of TPM plugins in `~/.tmux.conf`:

```tmux
set -g @plugin 'schasse/tmux-jump'
```

Hit <kbd>tmux-prefix</kbd> + <kbd>I</kbd> to fetch the plugin and source it.
You should now be able to use the plugin.

## Manual Installation

Clone the repository:

```shell
git clone https://github.com/schasse/tmux-jump ~/.tmux-jump
```

Add the following to `.tmux.conf`:

```tmux
run-shell ~/.tmux-jump/tmux-jump.tmux
```

Reload tmux:

```shell
tmux source-file ~/.tmux.conf
```

## Usage

* <kbd>tmux-prefix</kbd> + <kbd>j</kbd> and enter the first character of a word.
* The screen will rerender and highlight the keys to press to jump to the word.
* Type the key sequence of the word to jump to.
* The cursor moves to the word.

tmux-jump can also be used in in any program and during copy mode.

You can customize the key binding in your `.tmux.conf`:

```tmux
set -g @jump-key 's'
```

You can also customize foreground and background color:

```tmux
set -g @jump-bg-color '\e[0m\e[90m'
set -g @jump-fg-color '\e[1m\e[31m'
```

And the keys position:

```tmux
# keys will overlap with the word (default)
set -g @jump-keys-position 'left'

# keys will be at the left of the word without overlap
set -g @jump-keys-position 'off_left'
```

## Similar Projects

* [vimium](https://vimium.github.io/)
* [easymotion](https://github.com/easymotion/vim-easymotion)
* [ace-jump-mode](https://github.com/winterTTr/ace-jump-mode)
