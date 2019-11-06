# bashconfig
a collection of bash-utilities i source into my .bash_profile/.bashrc to automate everyday-tasks during development


For a quick overview, run:
```
  $ source bashconfig/all.sh
  $ printhelp
```

and you should see the following output:

```
  Overview:

  >>> alias ll='ls -l'
  >>> alias la='ls -l'
  >>> alias sbp='source ~/.bash_profile'
  >>> alias tr='tox -- --reuse-db'
  >>> alias ttr='tox -e py36 -- --reuse-db'
  >>> alias gs='git status'
  >>> alias gl='git log'
  >>> alias ga='git add'
  >>> alias gc='git commit -m'
  >>> alias gca='git commit --amend'
  >>> alias mkpy3='mkvirtualenv -p /usr/local/bin/python3'
  jsrelease -h      ->  clean and build a js project. optionally prep for release.
  devgo -h          ->  go to project and activate virtualenv
  devinstall -h     ->  install requirements for project, including local overrides
  setupvenv -h      ->  setup/recreate virtualenv for project
  resetproject -h   ->  shortcut for setupvenv + devinstall
  listyarnlink      ->  show all yarn-linked packages in current project
```

then just run e.g. `devgo -h` to see more detailed info on devgo.

Note that error-handling is not a big thing in these tools, since if you mess something up you should just be able to
run the same command again with the correct params and things should sort themselves out.
