load_lib kv
load_lib secrets

create_input_kv foo
create_input_secret bar
create_generate_secret baz

export FOO=$(get_kv foo)
export BAR=$(get_secret bar)
export BAZ=$(get_secret baz)
