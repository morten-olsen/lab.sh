#!/bin/bash

for CURRENT_DIR in "$STACK_ROOT/stacks/"*/; do
  (
    echo ""
    STACK_NAME="$(basename $CURRENT_DIR)"
    run_action status $STACK_NAME
  )
done

echo ""
