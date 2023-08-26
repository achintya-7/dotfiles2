zoxide init fish | source
starship init fish | source

fish_vi_key_bindings

set fish_vi_force_cursor line

# Emulates vim's cursor shape behavior
# Set the normal and visual mode cursors to a block
set fish_cursor_default block 
# Set the insert mode cursor to a line
set fish_cursor_insert line blink 
# Set the replace mode cursor to an underscore
set fish_cursor_replace_one underscore
# The following variable can be used to configure cursor shape in
# visual mode, but due to fish_cursor_default, is redundant here
set fish_cursor_visual block

set -x EDITOR "nvim"
set -x BROWSER "opera-developer"
# set -x TERM "kitty"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Remove fish greeting
set fish_greeting ""

# Functions needed for !! and !$
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end
# The bindings for !! and !$
if [ $fish_key_bindings = fish_vi_key_bindings ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

# Start su with fish instead of bash
function su
   command su --shell=/usr/bin/fish $argv
end

# Some cusotm commands for the lols

# Changing ls to exa
alias ls="exa -la --color=always --group-directories-first --icons --no-permissions --no-time --no-user"
alias lt="exa -aT --color=always --group-directories-first --icons"
alias la="exa -l --color=always --group-directories-first --icons"
alias ll="exa -a --color=always --group-directories-first --icons"

# Confirm before overwriting
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

# cd shortcuts
alias cd="z"
alias ..="z .."
alias ...="z ../.."
alias .4="z ../../.."
alias .5="z ../../../.."

alias snaproot="snapper -c root"
alias snaphome="snapper -c home"

# Extra flags
alias tree="exa --tree"
alias vim="nvim"
alias neofetch="neofetch --source $HOME/.config/neofetch/logo.txt"
alias tl="tldr -s"