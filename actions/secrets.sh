load_lib secrets

ACTION="$1"
shift

HELP="
lab.sh kv <action> [...args]

ACTIONS:
get <name>
set <name> <value>
remove <name>
keys

"

case "$ACTION" in
  "get") get_secret $@;;
  "set") set_secret $@;;
  "input") input_secret $@;;
  "remove") remove_secret $@;;
  "keys") list_secret_keys $@;;
  "help") echo "$HELP";;
  *) echo "command $ACTION not found";;
esac

