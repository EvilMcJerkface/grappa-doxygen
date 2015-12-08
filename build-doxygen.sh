#!/bin/bash

# abort on error
set -e

# clone source repo
git clone git@github.com:uwsampa/grappa

( cd grappa
    
  # get revision number (# commits in branch) and hash
  REVISION=$(git rev-list --count HEAD)
  HASH=$(git rev-parse HEAD)
  sed -i x -e "s/^PROJECT_NUMBER.*\$/PROJECT_NUMBER = prerelease r$REVISION, hash $HASH/" system/Doxyfile.in
  
  # build docs
  ./configure
  ( cd build/Make+Release
    make docs
  )
)

# clone docs repo
git clone git@github.com:uwsampa/grappa-doxygen

( cd grappa-doxygen
  git co gh-pages
  
  # remove old docs
  git rm -r html tags.xml
  
  # copy in new docs
  cp -a ../grappa/build/doxygen/html .
  git add html
  cp -a ../grappa/build/doxygen/tags.xml .
  git add tags.xml
  
  # commit and push
  git commit -m 'Add Doxygen-generated documentation'
  git push
)
