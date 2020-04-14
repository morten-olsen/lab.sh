#!/bin/bash

for CURRENT_DIR in "$STACK_ROOT/stacks/"*/; do
  (
    STACK_NAME="$(basename $CURRENT_DIR)"
    ENABLE_FILE="$STACK_ROOT/enabled/$STACK_NAME"
    [ -f "$ENABLE_FILE" ] && echo && echo "- $STACK_NAME" && run_action single "$STACK_NAME" $@
  )
done

echo ""

