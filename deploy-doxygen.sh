#!/bin/bash

# abort on error
set -e

# clone docs repo
git clone https://${GITHUB_TOKEN}:@github.com/uwsampa/grappa-doxygen

( cd grappa-doxygen

  git config push.default matching
  git config user.name Grappa Developers
  git config user.email grappa-dev@cs.washington.edu

  git checkout gh-pages
  
  # remove old docs
  git rm -r html tags.xml
  
  # copy in new docs
  cp -a ../grappa/build/doxygen/html .
  git add html
  cp -a ../grappa/build/doxygen/tags.xml .
  git add tags.xml
  
  # commit and push
  git commit -m "Add Doxygen-generated documentation"
  git push
)
