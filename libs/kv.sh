#!/bin/bash

KV_LOCATION="$STACK_ROOT/kv"

mkdir -p "$KV_LOCATION"

function list_kv {
  for CURRENT_DIR in "$KV_LOCATION/"*; do
    (
    KV_KEY="$(basename $CURRENT_DIR)"
    echo "$KV_KEY = `get_kv \"$KV_KEY\"`"
  )
  done
}

function list_kv_keys {
  for CURRENT_DIR in "$KV_LOCATION/"*; do
    (
    KV_KEY="$(basename $CURRENT_DIR)"
    echo "$KV_KEY"
  )
  done
}

function has_kv {
  NAME="$1"
  [ -f "$KV_LOCATION/$NAME" ] && return 0 || return 1
}

function get_kv {
  NAME="$1"
  KV_FILE="$KV_LOCATION/$NAME"
  [ -f "$KV_FILE" ] && cat "$KV_FILE" || throw_error "kv $NAME does not exist"
}

function set_kv {
  NAME="$1"
  VALUE="$2"
  KV_FILE="$KV_LOCATION/$NAME"
  echo "$VALUE" > "$KV_FILE"
}

function remove_kv {
  NAME="$1"
  KV_FILE="$KV_LOCATION/$NAME"
  rm -rf "$KV_FILE"
}

function create_input_kv {
  NAME="$1"
  has_kv "$NAME" || input_kv "$NAME"
}

function input_kv {
  NAME="$1"
  echo -ne "set value for kv $NAME: "
  read VALUE
  set_kv "$NAME" "$VALUE"
}

export -f input_kv
export -f has_kv
export -f get_kv
export -f set_kv
export -f list_kv
export -f list_kv_keys
export -f create_input_kv 
