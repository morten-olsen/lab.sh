load_lib stack

load_stack_info $1
shift

SCRIPT_NAME=$1
shift

run_action single "$STACK_NAME" bash "$STACK_LOCATION/scripts/$SCRIPT_NAME.sh" $@
