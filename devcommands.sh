jsrelease() {
  __printhelp() {
    echo ""
    echo "Helptext for 'jsrelease' command"
    echo ""
    echo "Performs a yarn install and build. Optionally clean before, and git add after build."
    echo ""
    echo "Usage:"
    echo ""
    echo "   \$ jsrelease [-c|-g|-w|-h]"
    echo ""
    echo "   -w (optional) - For development. Runs build-watch-verbose instead of build."
    echo "   -c (optional) - Clean before install. Deletes node_modules and lib folders."
    echo "   -g (optional) - Add lib, yarn.lock and package.json to git"
    echo "   -h (optional) - print this text"
    echo ""
    echo "Notes:"
    echo "   To run both clean and git-add, you must run -c -g, same applies to watch (-c -w)"
    echo ""
  }

  __yarninstall() {
    echo "Running yarn install and build"
    yarn
    yarn run build
  }

  __yarnwatch() {
    echo "Running yarn install and watch"
    yarn
    yarn run build-watch-verbose
  }

  __clean() {
    echo "Removing node_modules/ and lib/"
    rm -rf node_modules/
    rm -rf lib/
  }

  __gitadd() {
    echo "Adding lib, yarn.lock and package.json to repo"
    git add lib/
    git add yarn.lock
    git add package.json
  }

  echo "running jsrelease."
  if [ -z "$1" ]
  then
    echo "no params given, just performing yarn run build"
    __yarninstall
  elif [ "$1" == "-h" ]
  then
    __printhelp
  elif [ "$1" == "-c" ]
  then
    if [ -z "$2" ]
    then
      echo "Got clean only. Removing lib and node_modules before install"
      __clean
      __yarninstall
    elif [ "$2" == "-g" ]
    then
      echo "Cleaning repo, rebuilding and adding changes to git."
      __clean
      __yarninstall
      __gitadd
    elif [ "$2" == "-w" ]
    then
      echo "Cleaning repo, running build-watch"
      __clean
      __yarnwatch
    fi
  elif [ "$1" == "-w" ]
  then
    "Got watch only. Running build-watch"
    __yarnwatch
  elif [ "$1" == "-g" ]
  then
    "Got git only. Rebuilding and adding changes to git."
    __yarninstall
    __gitadd
  fi
}

devgo() {
  __printhelp() {
    echo ""
    echo "Helptext for 'devgo' command"
    echo ""
    echo "Goes to projectfolder (or staticsources in app), activates virtualenv and nvm, optionally opens pycharm or webstorm in destinationfolder."
    echo ""
    echo "Usage:"
    echo ""
    echo "   \$ devgo [-w|-c|-h] <projectname> [<subfolder>]"
    echo ""
    echo "   -w (optional) - open webstorm in destination folder"
    echo "   -c (optional) - open pycharm in destination folder"
    echo "   -h (optional) - display this helptext"
    echo "   <projectname> (required) - name of project to go to"
    echo "   <subfolder> (optional) - appname (excluding projectname prefix) to go to staticsources folder in. See example for clarification.."
    echo ""
    echo "Simple example - just go to projectfolder (hellsapp) and workon:"
    echo " \$ devgo hellsapp"
    echo " >>> cd ~/code/hellsapp/"
    echo " >>> workon hellsapp"
    echo " >>> nvm use stable"
    echo ""
    echo "Full example - go to staticsources folder (hellsapp_javascript) and open webstorm:"
    echo " \$ devgo -w hellsapp javascript"
    echo " >>> cd ~/code/hellsapp/hellsapp/hellsapp_javascript/staticsources/hellsapp_javascript"
    echo " >>> workon hellsapp"
    echo " >>> nvm use stable"
    echo " >>> wstorm ."
  }
  __gotoproject() {
    if [ -z "$1" ]
      then
      echo "Cannot go to project without projectname!"
      echo 'run "$ devgo -h" for helptext'
    else
      cd ~/code/$1
      workon $1
      # NOTE: If using node 9.11.1, you need to do this (nvm use default) twice
      # to workaround npm-prefix-issues.. Fixed some time before node v12.13
      nvm use default
      if [ -z "$2" ]
      then
        echo "All good - in project root"
      elif [ "$2" == '-v' ]
      then
        echo "Deactivating $1 and workon $3"
        deactivate
        workon $3
      else
        cd $1/$1_$2/staticsources/$1_$2
        echo "All good - in staticsources folder!"
      fi
    fi
  }
  if [ -z "$1" ]
    then
      __printhelp
      echo ""
      echo ""
      echo "Missing parameter: project name!"
      echo "Moving to code-folder..."
      cd ~/code
    else
      if [ "$1" == "-c" ]
      then
        __gotoproject "$2" "$3" "$4"
        echo "starting pycharm"
        charm .
      elif [ "$1" == "-w" ]
        then
        __gotoproject "$2" "$3" "$4"
        echo "starting webstorm"
        wstorm .
      elif [ "$1" == "-h" ]
        then
        __printhelp
      else
        __gotoproject "$1" "$2" "$3"
      fi
  fi
}

devinstall() {
  __printhelp() {
    echo ""
    echo "Helptext for 'devinstall' command"
    echo ""
    echo "Installs local (~/code/...) project."
    echo "Runs pip uninstall <projectname> \&\& pip install -e ~/code/<projectname>"
    echo ""
    echo "Usage:"
    echo ""
    echo "   \$ devinstall [-h|-c|<projectname><requirements><packagenames...>]"
    echo ""
    echo "   -h (optional) - display this helptext"
    echo "   -c (optional) - clean install using first argument as requirements.txt, then devinstall all other arguments."
    echo "   <projectname> - required as long as you want anything apart from helptext.."
    echo ""
    echo "Examples:"
    echo "  Install local package ievv_churchill with pip:"
    echo "    \$ devinstall ievv_churchill"
    echo ""
    echo "  Clean install from requirements, then install local packages ievv_churchill, ievv, turafak and django_cradmin:"
    echo "    \$ devinstall -c requirements/develop.txt ievv_churchill ievv turafak django_cradmin"
    echo ""
  }

  __devinstall() {
    echo "Uninstalling current $1 and installing from ~/code/$1 instead..."
    pip uninstall -y $1
    pip install -e ~/code/$1
  }

  __cleaninstall() {
    echo "running pip install -r $1"
    pip install -r $1
  }

  __loopinstall() {
    if [ -z "$1" ]
      then
        echo ""
        echo ""
        echo "No more local packages provided."
        echo ""
    else
      __devinstall $1
      __loopinstall ${@:2}
    fi
  }

  if [ -z "$1" ]
    then
      __printhelp
      echo ""
      echo ""
      echo "ERROR: Missing parameter projectname!"
      echo ""
  else
    if [ "$1" == "-h" ]
      then
        __printhelp
    elif [ "$1" == "-c" ]
      then
        if [ -z "$2" ]
          then
            echo "Cannot perform clean install without requirements path (should be first argument after -c)!"
        else
          __cleaninstall "$2"
          if [ -z "$3" ]
            then
              echo "No local packages provided. All done!"
          else
            __loopinstall ${@:3}
            echo "Installed local packages: ${@:3}"
            echo ""
            echo "All done!"
            echo ""
          fi
        fi
    else
        __devinstall "$1"
    fi
  fi
}

setupvenv() {
  __printhelp() {
    echo ""
    echo "(Re)create a virtualenv with given name and given python-version."
    echo ""
    echo "Usage:"
    echo "  \$ setupvenv [-h|-n|-c] <pythonversion> <projectname>"
    echo ""
    echo "    -h    display this helptext"
    echo "    -n    create a new virtualenv (only use if no virtualenv with same name exists alredy)"
    echo "    -c    delete old virtualenv and create a new one."
    echo ""
    echo "Example:"
    echo "  Delete old virtualenv and create a new one using python3 for ievv_churchill"
    echo "    \$ setupvenv -c p3 ievv_churchill"
    echo ""
    echo "  Create a new virtualenv using python2 for myproject"
    echo "    \$ setupenv -n p2 myproject"
    echo ""
  }

  __removeenv() {
    echo "Removing virtualenv $1"
    rmvirtualenv $1
  }

  __createenv() {
    echo "Creating virtualenv $2 using python v$1"
    if [ "$1" == "p2" ]
      then
        echo "Using python2..."
        mkvirtualenv $2
    elif [ "$1" == "p3" ]
      then
        echo "using python3..."
        mkvirtualenv -p /usr/local/bin/python3 $2
    else
      echo "No python-version given! Aborting.."
    fi
  }

  if [ "$1" == "-h" ]
    then
      __printhelp
  elif [ "$#" -lt "3" ]
    then
      __printhelp
      echo ""
      echo ""
      echo "ERROR: Missing parameters! Aborting."
      echo ""
  else
    echo "Attempting to deactivate virtualenv just in case.."
    deactivate
    echo ""

    if [ "$1" == "-n" ]
      then
        echo "Setting up new virtualenv"
        __createenv ${@:2}
    elif [ "$1" == "-c" ]
      then
        echo "Deleting and recreating virtualenv $3"
        __removeenv $3
        __createenv ${@:2}
    fi
  fi
}

resetproject() {
  __printhelp() {
    echo ""
    echo "Shortcut for running setupvenv and devinstall!"
    echo ""
    echo "Recreates a virtualenv and installs dependencies."
    echo ""
    echo "The first 3 parameters are passed to setupvenv (see setupvenv -h for details)."
    echo "All other parameters are passed to devinstall (see devinstall -h for details)."
    echo ""
    echo "Example:"
    echo "  Recreate a python3 virtualenv for arbeiderpartiet and install requirements with local override for ievv_churchill"
    echo "    \$ resetproject -c p3 arbeiderpartiet -c requirements/develop.txt ievv_churchill"
    echo ""
    echo ""
  }

  if [ "$1" == "-h" ]
    then
      __printhelp
  elif [ "$#" -lt "5" ]
    then
      __printhelp
      echo ""
      echo ""
      echo "ERROR: Missing parameters! Aborting."
      echo ""
  else
    setupvenv "$1" "$2" "$3"
    devinstall ${@:4}
  fi
}

listyarnlink () {
  find node_modules node_modules/\@* -depth 1 -type l -print | while read MODULE ; do
    echo "Linked module in use: $MODULE"
  done
}
