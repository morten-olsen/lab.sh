load_lib kv

ACTION="$1"
shift

HELP="
lab.sh kv <action> [...args]

ACTIONS:
get <name>
set <name> <value>
remove <name>
list
keys

"

case "$ACTION" in
  "get") get_kv $@;;
  "set") set_kv $@;;
  "remove") remove_kv $@;;
  "list") list_kv $@;;
  "keys") list_kv_keys $@;;
  "help") echo "$HELP";;
  *) echo "command $ACTION not found";;
esac
