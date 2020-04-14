load_lib stack
load_stack_info $1
shift

run_action single $STACK_NAME docker-compose up -d
run_stack $STACK_NAME docker-compose logs -f
