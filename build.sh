#!/usr/bin/env bash
#
# Created on Sun Apr 26 2020
#
# This script is meant to build and compile every protocolbuffer for each
# service declared in this repository (as defined by sub-directories).
# It compiles using docker containers based on Namely's protoc image
# seen here: https://github.com/namely/docker-protoc
#
# @authors nirajgeorgian@oojob.io (Niraj Kishore)
#
# Copyright (c) 2020 - oojob

set -e

REPOPATH=${REPOPATH-/Users/oooo/Desktop/my-job/protolangs/build}
CURRENT_BRANCH=${CURRENT_BRANCH-"master"}

# Helper for adding a directory to the stack and echoing the result
function enterDir {
  echo "Entering $1"
  pushd $1 > /dev/null
}

# Helper for popping a directory off the stack and echoing the result
function leaveDir {
  echo "Leaving `pwd`"
  popd > /dev/null
}

# Enters the directory and starts the build / compile process for the services
# protobufs
function buildDir {
  currentDir="$1"
  if [ -d $currentDir ];
  then
    echo "Building directory \"$currentDir\""

    # # enter directory script
    # enterDir $currentDir

    # build our execution/task
    buildProtoForTypes $currentDir

    # # leave the directory
    # leaveDir
  fi
}

# Iterates through all of the languages listed in the services .protolangs file
# and compiles them individually
function buildProtoForTypes {
  # target=${1%/}
  # echo $target

  rm -rf build/doc
  git clone git@github.com:oojob/oojob.github.io build/doc

  docker run -v `pwd`:/defs namely/protoc-all -d github.com/oojob/protobuf -l go --with-docs --lint --with-validator
  rm -rf build/go/protobuf
  git clone git@github.com:oojob/protobuf.git build/go/protobuf
  cp -R gen/pb-go/* build/go/protobuf/

  docker run -v `pwd`:/defs namely/protoc-all -d github.com/oojob/protobuf -l node --with-docs --lint --with-typescript
  rm -rf build/node/oojob-protobuf
  git clone git@github.com:oojob/oojob-protobuf.git build/node/oojob-protobuf
  cp -R gen/pb-node/* build/node/oojob-protobuf/

  mkdir -p build/doc/protobuf
  mkdir -p build/doc/oojob-protobuf
  cp build/node/oojob-protobuf/doc/index.html build/doc/oojob-protobuf/
  rm -rf gen

  commitAndPush build/go/protobuf
  commitAndPush build/node/oojob-protobuf

  # BASE_PACKAGE=$target/oojob
  for src in */; do
    if [ $src == 'services/' ]; then
      for target in `pwd`/services/*; do
        if [ -f $target/.protolangs ]; then
          while read lang; do
          # build the repo name
          # space is set as delimiter
          IFS='/' read -r directory <<< "$target"
          dir=${target##*/}

          reponame="protorepo-$dir-$lang"

          rm -rf $REPOPATH/$lang/$reponame
          echo "removed $reponame for updating ..."

          # Clone the repository down and set the branch to the automated one
          echo "Cloning repo: git@github.com:oojob/$reponame.git"
          git clone git@github.com:oojob/$reponame.git $REPOPATH/$lang/$reponame
          setupBranch $REPOPATH/$lang/$reponame
          # mkdir -p $REPOPATH/$lang/$reponame

          # Use the docker container for the language we care about and compile
          PROTO_FILE=services/$dir/service.proto
          PROTO_INCLUDE=oojob/
          ADDITIONAL_ARGS=$([ $lang == 'node' ] && echo "--with-typescript" || echo "--with-validator")
          docker run -v `pwd`:/defs namely/protoc-all -f $PROTO_FILE  -i $PROTO_INCLUDE -l $lang --with-docs --lint $ADDITIONAL_ARGS

          # Copy the generated files out of the pb-* path into the repository that we care about
          cp -R gen/pb-$lang/services/$dir/* gen/pb-$lang/
          rm -rf gen/pb-$lang/services
          cp -R gen/pb-$lang/* $REPOPATH/$lang/$reponame/
          rm -rf gen
          mkdir -p $REPOPATH/doc/$reponame
          cp $REPOPATH/$lang/$reponame/doc/index.html $REPOPATH/doc/$reponame/

          commitAndPush $REPOPATH/$lang/$reponame
          # if [ $lang == "node" ]
          # then
          #   commitAndPushNpmPackage $REPOPATH/$lang/$reponame
          # else
          #   commitAndPush $REPOPATH/$lang/$reponame
          # fi
          done < $target/.protolangs
        fi
      done
    fi
  done

  nohup npx serve -d build/doc &
  sleep 1
  wget localhost:5000
  mv index.html build/doc
  killall -9 node

  commitAndPush build/doc
}

function setupBranch {
  enterDir $1

  echo "Creating branch"

  if ! git show-branch $CURRENT_BRANCH; then
    git branch $CURRENT_BRANCH
  fi

  git checkout $CURRENT_BRANCH

  if git ls-remote --heads --exit-code origin $CURRENT_BRANCH; then
    echo "Branch exists on remote, pulling latest changes"
    git pull origin $CURRENT_BRANCH
  fi

  leaveDir
}

function commitAndPush {
  enterDir $1

  git add -N .

  if ! git diff --exit-code > /dev/null; then
    git add .
    git commit -m "Auto Creation of Proto"
    git push origin HEAD
  else
    echo "No changes detected for $1"
  fi

  leaveDir
}

function commitAndPushNpmPackage {
  enterDir $1

  git add -N .

  if ! git diff --exit-code > /dev/null; then
    git add .
    git commit -m "Auto Creation of Proto"
    npm install
    npm run release
    git push --follow-tags origin master && npm publish
  else
    echo "No changes detected for $1"
  fi

  leaveDir
}

# Finds all directories in the repository and iterates through them calling the
# compile process for each one
function buildAll {
  echo "Buidling service's protocol buffers"
  
  mkdir -p $REPOPATH
  mkdir -p $REPOPATH/{node,go,doc}

  buildProtoForTypes
}

buildAll