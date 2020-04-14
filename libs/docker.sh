function docker_require_network {
  NAME=$1
  [ -z "`docker network list -q -f name=\"$NAME\" | grep -w \"$NAME\"`" ] && docker network create "$NAME" && sleep 1
  return 0
}
