load_lib stack

load_stack_info $1
GIT_REPO_URL="$2"

git clone "$GIT_REPO_URL" "$STACK_LOCATION"

