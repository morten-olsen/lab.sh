#!/bin/bash
load_lib stack

load_stack_info $1
shift

[ -d "$STACK_LOCATION" ] && rm "$STACK_LOCATION"
