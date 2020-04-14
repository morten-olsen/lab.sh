#!/bin/bash
load_lib stack

load_stack_info $1
shift
RAW_LOCATION="${1:-`pwd`}"
LOCATION="`realpath $RAW_LOCATION`"

[ ! -d $LOCATION ] && echo "$LOCATION not found" && exit 1

ln -s "$LOCATION" "$STACK_LOCATION" && echo "$LOCATION -> $STACK_LOCATION"
