#!/bin/bash
function load_stack_info {
  STACK_NAME="$1"
  STACK_LOCATION="$STACK_ROOT/stacks/$1"
  DATA_LOCATION="$STACK_ROOT/data/$STACK_NAME"

  export STACK_LOCATION
  export DATA_LOCATION
  export STACK_NAME
}

function run_stack {
  (
    load_stack_info $1
    shift
    cd "$STACK_LOCATION"
    $@
  )
  return 0
}

function stack_exists {
  load_stack_info $1
  echo $STACK_LOCATION
  shift
  [ -d "$STACK_LOCATION" ] && return 0 || return 1
}

function setup_stack {
  load_stack_info $1
  mkdir -p "$DATA_LOCATION"
  mkdir -p "$STACK_LOCATION"
  shift
  [ -f "$STACK_LOCATION/prepare.sh" ] && source "$STACK_LOCATION/prepare.sh"
  return 0
}

