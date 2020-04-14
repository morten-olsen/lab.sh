load_lib stack
load_stack_info $1
shift

mkdir -p "$STACK_ROOT/enabled"

touch "$STACK_ROOT/enabled/$STACK_NAME"
