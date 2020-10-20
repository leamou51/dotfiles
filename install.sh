#!/bin/zsh

set -e

link() {
  from="$PWD/links/$1"
  to="$2"
  [[ ! $to ]] && to="$HOME/$1"

  if [[ ! -f $to ]]; then
    echo "-----> Linking $to"
    mkdir -p "`dirname $to`"
    ln -s $from $to
  fi
}

copy() {
  from="$PWD/copies/$1"
  to="$2"
  [[ ! $to ]] && to="$HOME/$1"

  if [[ ! -f $to ]]; then
    echo "-----> Creating $to"
    mkdir -p "`dirname $to`"
    cp $from $to
  fi
}

install_zsh_plugin() {
  CURRENT_DIR=`pwd`
  ZSH_PLUGINS_DIR="$HOME/.oh-my-zsh/custom/plugins"
  mkdir -p "$ZSH_PLUGINS_DIR" && cd "$ZSH_PLUGINS_DIR"
  if [ ! -d "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting" ]; then
    echo "-----> Installing zsh plugin 'zsh-syntax-highlighting'..."
    git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
  fi
  cd "$CURRENT_DIR"
}

# Plugins
install_zsh_plugin

# Links
link .aliases
link .gemrc
link .gitconfig
link .gitignore
link .irbrc
link .psqlrc
link .rspec
link .tmux.conf
link .zshrc
link .hushlogin
link bin/git-fetch-and-delete
link bin/gh-rename-master
link .psql/.keep
link vscode-settings.json "$HOME/Library/Application Support/Code/User/settings.json"

# Copies
copy .config/git/template/HEAD
copy .zshlocal

setopt nocasematch
if [[ ! `uname` =~ "darwin" ]]; then
  git config --global core.editor "subl -n -w $@ >/dev/null 2>&1"
  echo 'export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1 -a"' >> zshrc
else
  git config --global core.editor "'/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl' -n -w"
  bundler_editor="'/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl'"
  echo "export BUNDLER_EDITOR=\"${bundler_editor} -a\"" >> zshrc
fi

# Sublime Text
if [[ ! `uname` =~ "darwin" ]]; then
  SUBL_PATH=~/.config/sublime-text-3
else
  SUBL_PATH=~/Library/Application\ Support/Sublime\ Text\ 3
fi
mkdir -p $SUBL_PATH/Packages/User $SUBL_PATH/Installed\ Packages
backup "$SUBL_PATH/Packages/User/Preferences.sublime-settings"
curl -k https://sublime.wbond.net/Package%20Control.sublime-package > $SUBL_PATH/Installed\ Packages/Package\ Control.sublime-package
ln -s $PWD/Preferences.sublime-settings $SUBL_PATH/Packages/User/Preferences.sublime-settings
ln -s $PWD/Package\ Control.sublime-settings $SUBL_PATH/Packages/User/Package\ Control.sublime-settings
ln -s $PWD/SublimeLinter.sublime-settings $SUBL_PATH/Packages/User/SublimeLinter.sublime-settings
