#!/bin/bash

# preparation and launch script for vagrant
if [ -f Vagrantfile ]; then
  if [ ! -d libreoffice ]; then
    echo "Now git clone libreoffice/core!"
    echo "Please wait several minutes..."
    git clone git://gerrit.libreoffice.org/core libreoffice
  elif [ ! -d libreoffice/.git ]; then
    echo "git source error!!"
    echo "please check whether libreoffice directory is git work directory"
  else
    echo "You have git work directory"
    echo "skip cloning"
  fi
else
  echo "Please run $0 on Vagrant directory"
fi

echo "update submodules: translations"
(cd libreoffice;git submodule init;git submodule update translations)

echo "Start building with vagrant"
vagrant up

