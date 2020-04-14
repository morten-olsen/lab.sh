#!/bin/bash

SECRET_LOCATION="$STACK_ROOT/secrets"

mkdir -p "$SECRET_LOCATION"

function unlock_vault {
  A='B'
}

function has_secret {
  NAME=$1
  [ -f "$SECRET_LOCATION/$NAME" ] && return 0 || return 1
}

function get_secret {
  NAME=$1 
  SECRET_FILE="$SECRET_LOCATION/$NAME"
  [ -f "$SECRET_FILE" ] && cat "$SECRET_FILE" || throw_error "secret $NAME does not exist"
}

function set_secret {
  NAME="$1"
  VALUE="$2"
  SECRET_FILE="$SECRET_LOCATION/$NAME"
  echo "$VALUE" > "$SECRET_FILE"
}

function remove_secret {
  NAME=$1
  SECRET_FILE="$SECRET_LOCATION/$NAME"
  rm -rf "$SECRET_FILE"
}

function generate_secret {
  PASS="`< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;`"
  echo "$PASS"
}

function input_secret {
  NAME="$1"
  echo -ne "set value for secret $NAME: "
  read VALUE
  set_secret "$NAME" "$VALUE"
}

function create_input_secret {
  NAME="$1"
  has_secret "$NAME" || input_secret "$NAME"
}

function create_generate_secret {
  NAME="$1"
  has_secret "$NAME" || set_secret "$NAME" "`generate_secret`"
}

function list_secret_keys {
  for CURRENT_DIR in "$SECRET_LOCATION/"*; do
    (
    SECRET_KEY="$(basename $CURRENT_DIR)"
    echo "$SECRET_KEY"
  )
  done
}

export -f unlock_vault
export -f has_secret
export -f get_secret
export -f set_secret
export -f input_secret
export -f generate_secret
export -f list_secret_keys
export -f create_input_secret 
export -f create_generate_secret

unlock_vault
