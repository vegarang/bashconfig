echo "setting brew, flags etc.."
source ~/code/bashconfig/system.sh
echo "setting up js-env"
source ~/code/bashconfig/jssetup.sh
echo "setting up virtualenvwrapper"
source ~/code/bashconfig/virtualenvsetup.sh
echo "registering custom dev-commands"
source ~/code/bashconfig/aliases.sh
source ~/code/bashconfig/devcommands.sh
echo "Done!"


printhelp() {
  echo ""
  echo "Overview:"
  echo ""
  echo ">>> alias ll='ls -l'"
  echo ">>> alias la='ls -l'"
  echo ">>> alias sbp='source ~/.bash_profile'"
  echo ">>> alias tr='tox -- --reuse-db'"
  echo ">>> alias ttr='tox -e py36 -- --reuse-db'"
  echo ">>> alias gs='git status'"
  echo ">>> alias gl='git log'"
  echo ">>> alias ga='git add'"
  echo ">>> alias gc='git commit -m'"
  echo ">>> alias gca='git commit --amend'"
  echo ">>> alias mkpy3='mkvirtualenv -p /usr/local/bin/python3'"
  echo "jsrelease -h      ->  clean and build a js project. optionally prep for release."
  echo "devgo -h          ->  go to project and activate virtualenv"
  echo "devinstall -h     ->  install requirements for project, including local overrides"
  echo "setupvenv -h      ->  setup/recreate virtualenv for project"
  echo "resetproject -h   ->  shortcut for setupvenv + devinstall"
  echo "listyarnlink      ->  show all yarn-linked packages in current project"
  echo ""
}
