# Documentation: https://github.com/romkatv/zsh4humans/blob/v2/README.md.
#
# Z4H Config Options
#

# 'ask': ask to update; 'no': disable auto-update.
zstyle ':z4h:' auto-update                     ask
# Auto-update this often; has no effect if auto-update is 'no'.
zstyle ':z4h:'                auto-update-days 28
# Stability vs freshness of plugins: stable, testing or dev.
zstyle ':z4h:*'               channel          stable
# Bind alt-arrows or ctrl-arrows to change current directory?
# The other key modifier will be bound to cursor movement by words.
zstyle ':z4h:'                cd-key           alt
# Right-arrow key accepts one character ('partial-accept') from
# command autosuggestions or the whole thing ('accept')?
zstyle ':z4h:autosuggestions' forward-char     accept
# Sort completion candidates when pressing Tab?
zstyle ':completion:*'                           sort               false
# Should cursor go to the end when Up/Down/Ctrl-Up/Ctrl-Down fetches a command from history?
zstyle ':zle:(up|down)-line-or-beginning-search' leave-cursor       no
# When presented with the list of choices upon hitting Tab, accept selection and
# trigger another completion with this key binding. Great for completing file paths.
zstyle ':fzf-tab:*'                              continuous-trigger tab
# ssh
zstyle    ':z4h:ssh:*'                                   ssh-command            command ssh
zstyle    ':z4h:ssh:*'                                   send-extra-files       '~/.zsh-aliases'
zstyle -e ':z4h:ssh:*'                                   retrieve-history       'reply=($ZDOTDIR/.zsh_history.${(%):-%m}:$z4h_ssh_host)'
zstyle    ':z4h:ssh:router'                              passthrough            yes
zstyle    ':z4h:term-title:ssh'                          preexec                '%* | %n@%m: ${1//\%/%%}'
zstyle    ':z4h:term-title:local'                        preexec                '%* | ${1//\%/%%}'

if (( UID && UID == EUID && ! Z4H_SSH )); then
  # When logged in as a regular user and not via `z4h ssh`, check that
  # login shell is zsh and offer to change it if it isn't.
  z4h chsh
fi

z4h install romkatv/archive || return
z4h install agkozak/zsh-z || return


# Install or update core components (fzf, zsh-autosuggestions, etc.) and
# initialize Zsh. After this point console I/O is unavailable. Everything
# that requires user interaction or can perform network I/O must be done
# above. Everything else is best done below.
z4h init || return

z4h source -c $Z4H/agkozak/zsh-z/zsh-z.plugin.zsh
fpath+=($Z4H/romkatv/archive)

# Autoload functions.
autoload -Uz zmv archive lsarchive unarchive edit-command-line

# Enable emacs (-e) or vi (-v) keymap.
bindkey -e

# Define key bindings.
bindkey -M emacs '^H' backward-kill-word # Ctrl-H and Ctrl-Backspace: Delete previous word.

# Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
setopt glob_dots  # glob matches files starting with dot; `ls *` becomes equivalent to `ls *(D)`

z4h source -c ~/.zsh-aliases
z4h source -c ~/.zshrc-private

# kitty completions
command -v kitty &> /dev/null && kitty + complete setup zsh | source /dev/stdin

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Load pyenv automatically by adding
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv &> /dev/null && eval "$(pyenv init -)"
command -v pyenv &> /dev/null && eval "$(pyenv virtualenv-init -)"
command -v pyenv &> /dev/null && z4h source -c "$(pyenv root)/completions/pyenv.zsh"

return 0
