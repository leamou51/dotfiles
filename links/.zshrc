ZSH="$HOME/.oh-my-zsh"

# You can change the theme with another one:
#   https://github.com/robbyrussell/oh-my-zsh/wiki/themes
ZSH_THEME="robbyrussell"

# Skip the verification of insecure directories.
ZSH_DISABLE_COMPFIX="true"

# Oh My Zsh plugins
plugins=(
  gitfast
  brew
  nvm
  rbenv
  last-working-dir
  common-aliases
  sublime
  zsh-syntax-highlighting
  history-substring-search
)

# Actually load Oh-My-Zsh.
source "$ZSH/oh-my-zsh.sh"

# Include sbins.
export PATH="$PATH:/usr/local/sbin"

# Helm 2 bins.
export PATH="/usr/local/opt/helm@2/bin:$PATH"

# MySQL 5.6 bins.
#export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"

# Yarn's bins.
export PATH="$HOME/.yarn/bin:$PATH"

# Your home bin directory.
export PATH="$HOME/bin:$PATH"

# Projects using a local `bin` folder to store binstubs will let you
# run `rails` instead of `bin/rails`.
export PATH="./bin:$PATH"

# Encoding stuff for the terminal.
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Editor
export BUNDLER_EDITOR="'/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl' -a"

# Help rmagick find imagemagick 6's pkgconfig on gem install.
export PKG_CONFIG_PATH=/usr/local/opt/imagemagick@6/lib/pkgconfig

# MySQL 5.6
#export DYLD_LIBRARY_PATH=/usr/local/opt/mysql@5.6/bin:$DYLD_LIBRARY_PATH

# On MySQL 5.6 gem installs you may also need:
# export LDFLAGS="-L/usr/local/opt/mysql@5.6/lib"
# export CPPFLAGS="-I/usr/local/opt/mysql@5.6/include"

# https://github.com/ansible/ansible/issues/32499#issuecomment-341578864
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# Load z.
[[ -f "/usr/local/etc/profile.d/z.sh" ]] && source /usr/local/etc/profile.d/z.sh

# Load direnv.
if hash direnv 2> /dev/null; then
  eval "$(direnv hook zsh)"
fi

# iTerm2 shell integration.
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
iterm2_print_user_vars() {
  iterm2_set_user_var gitBranch $((git branch 2> /dev/null) | grep \* | cut -c3-)
}
# iTerms2 badges
function iterm2_print_user_vars() {
  iterm2_set_user_var badge $(dir_badges)
}

function dir_badges() {
    while read directory badge || [[ -n "$directory" ]]
    do
        if [[ "$PWD" == $directory* ]]; then
            echo $badge
            break
        fi
    done < ~/.badges
}

# Nvm bash completion.
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

# Nvm autoloading
# Via https://medium.com/@kinduff/automatic-version-switch-for-nvm-ff9e00ae67f3
autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  elif [[ $(nvm version) != $(nvm version default)  ]]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
if hash nvm 2> /dev/null; then
  add-zsh-hook chpwd load-nvmrc
  load-nvmrc
fi

# Store your own aliases in the ~/.aliases file and load the here.
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# Load local configuration
[ -f "$HOME/.zshlocal" ] && source "$HOME/.zshlocal"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/Users/sunny/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;

# To link Rubies to Homebrew's OpenSSL 1.1 (which is upgraded)
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

# Mangopay Sandbox
export GRINGOTTS_TOKEN=leamousel
export SANDBOX_PASSPHRASE=rcfQbhJ2bdCRP00Kn2ZZ5OanoGd8EBn16ppFMtvtkYYg8TRyw1

export PATH="/usr/local/opt/postgresql@9.5/bin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"

# Repo aliases
alias client='cd ~/code/kkbb-lendopolis-clients'
alias front='cd ~/code/kkbb-lendopolis-clients/front'
alias dash='cd ~/code/kkbb-lendopolis-clients/dashboard'
alias back='cd ~/code/kkbb-lendopolis'
alias sgt='cd ~/code/sgt_papers'
alias gring='cd ~/code/gringotts'
alias kitten='cd ~/code/kitten'
