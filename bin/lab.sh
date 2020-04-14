#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

TOOLS_ROOT="`realpath \"$DIR/..\"`"
STACK_ROOT="${LAB_SH_ROOT:-$HOME/.lab}"

mkdir -p "$STACK_ROOT/data"
mkdir -p "$STACK_ROOT/stacks"

function throw_error {
  echo "ERROR: $1"
  exit 1
}

function load_lib {
  NAME=$1
  LIB_LOCATION="$TOOLS_ROOT/libs/$NAME.sh"
  [ -f "$LIB_LOCATION" ] && source "$LIB_LOCATION" || (echo "Lib $LIB_LOCATION not found" && exit 1)
}

function run_action {
  ACTION=$1
  SCRIPTPATH="$TOOLS_ROOT/actions/$ACTION.sh"
  shift
  ARGS=$@

  if [ -f "$SCRIPTPATH" ]; then
    bash "$SCRIPTPATH" $ARGS
  else
    echo "Command $SCRIPTPATH not found"
  fi
}

export TOOLS_ROOT
export STACK_ROOT
export -f load_lib
export -f run_action
export -f throw_error

[ -f "$HOME/.labrc" ] && source "$HOME/.labrc"

run_action $@

