function get_network_name {
  NAME="$1"
  echo "$NAME"
}

function require_network {
  NAME=$(get_network_name "$1")
  [ -z "`docker network list -q -f name=\"$NAME\" | grep -w \"$NAME\"`" ] && docker network create "$NAME" && sleep 1
  return 0
}
