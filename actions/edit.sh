#!/bin/bash

load_lib stack
load_stack_info $1
shift

run_stack $STACK_NAME "${EDITOR:-vim}" $@
