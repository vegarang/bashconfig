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
  cat ~/code/bashconfig/aliases.sh
  echo ""
  echo "jsrelease -h      ->  clean and build a js project. optionally prep for release."
  echo "devgo -h          ->  go to project and activate virtualenv"
  echo "devinstall -h     ->  install requirements for project, including local overrides"
  echo "setupvenv -h      ->  setup/recreate virtualenv for project"
  echo "resetproject -h   ->  shortcut for setupvenv + devinstall"
  echo "listyarnlink      ->  show all yarn-linked packages in current project"
  echo ""
}
