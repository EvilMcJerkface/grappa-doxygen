#!/bin/bash

# abort on error
set -e

# clone source repo
git clone http://github.com/uwsampa/grappa

( cd grappa
    
  # get revision number (# commits in branch) and hash
  REVISION=r$(git rev-list --count HEAD)
  HASH=$(git rev-parse HEAD)
  VERSION_STRING="$REVISION, hash $HASH"
  sed -i.x -e "s/^PROJECT_NUMBER.*\$/PROJECT_NUMBER = \"$VERSION_STRING\"/" system/Doxyfile.in

  
  # build docs
  ./configure
  ( cd build/Make+Release
    make docs
  )
)
