load_lib stack
load_stack_info $1
shift

run_action compose $STACK_NAME up -d
run_action compose $STACK_NAME logs -f
