load_lib kv
load_lib secrets
load_lib docker

create_input_kv foo
create_input_secret bar
create_generate_secret baz

export FOO=$(get_kv foo)
export BAR=$(get_secret bar)
export BAZ=$(get_secret baz)

docker_require_network example
