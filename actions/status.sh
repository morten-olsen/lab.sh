#!/bin/bash

load_lib stack

load_stack_info $1
shift

GIT_STATUS="not initialized"

[ ! -z "`run_stack $STACK_NAME docker-compose ps -q`" ] && DOCKER_STATUS="running" || DOCKER_STATUS="stopped"
[ -f "$STACK_ROOT/enabled/$STACK_NAME" ] && ENABLE_STATUS="yes" || ENABLE_STATUS="no"
if [ -d "$STACK_LOCATION/.git" ]; then
  [ ! -z "`run_stack $STACK_NAME git status --porcelain`" ] && GIT_STATUS="changed" || GIT_STATUS="up to date"
fi


echo "$STACK_NAME (`realpath \"$STACK_LOCATION\"`)"
echo "::: enabled: $ENABLE_STATUS"
echo "::: docker: $DOCKER_STATUS"
echo "::: git: $GIT_STATUS"
