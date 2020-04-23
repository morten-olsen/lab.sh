#!/bin/bash

load_lib stack
load_stack_info $1
shift
stack_exists $STACK_NAME || throw_error "stack not found"
setup_stack $STACK_NAME && run_stack $STACK_NAME docker-compose -p "$CURRENT_LAB_$STACK_NAME" $@
