#!/bin/bash

load_lib stack

load_stack_info $1
shift
echo cd `realpath "$STACK_LOCATION"`
