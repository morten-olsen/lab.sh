# lab.sh

## TODO

* [ ] Improve documentation
* [ ] Encryption for secrets
* [ ] Improved status display
* [ ] Protect against unlinking non linked stacks
* [ ] Better error handling

## Installing

**With npm**
```
$ git clone https://github.com/morten-olsen/lab.sh
$ cd lab.sh
$ npm link
```

**Without npm**
```
$ git clone https://github.com/morten-olsen/lab.sh
$ cd lab.sh
# ln -s $PWD/bin/lab.sh /usr/bin/
```

## Usage

`lab.sh` uses "stacks", which are simply folders with a `docker-compose.yml` file.

To create a sample stack create a folder and add your `docker-compose.yml` and inside this directory
run `lab.sh link example`. This creates a service link to your service with the name "example"

Start the service using `lab.sh start example` to run the service

You can also "enable" the service stack using `lab.sh enable example` and then you can issue
commands to it using `lab.sh all your-commands` for instance `lab.sh all pwd` will print the
directory of all enabled services

You can also add a `prepare.sh` file to your service stack folder which will be sourced before
commands are issued to the service

Take a look inside `./example` to see a simple service
To link it run `lab.sh link example ./example` and then start it using `lab.sh start example`

### General actions

* `all <STACK_NAME> [...COMMAND]`: Run a command across all enabled stacks
* `enable <STACK_NAME>`: Mark a stack as enabled (making it available in `all` actions)
* `disable <STACK_NAME>`: Mark a stack as disables
* `edit <STACK_NAME> [FILE]`: Edit a file inside a stack folder
* `link <STACK_NAME> [PATH]`: Link PATH (defaults to $PWD) inside the stack folder
* `status <STACK_NAME`: Display status of a stack (is enabled, git is clean and if it has any containers running)
* `list`: Display a list of stacks and their status
* `single <STACK_NAME> [...COMMAND]`: Run a command inside a stack folder
* `start <STACK_NAME>`: Start a stack
* `stop <STACK_NAME>`: Stop a stack
* unlink <STACK_NAME>: Remove a stack folder/link from stacks

**Navigate to stack**:
To navigate to a stack folder you can add the following snippit to you profile

```
function lab.cd {
  eval $(lab.sh "$1")
}
```

and then use `lab.cd <STACK_NAME>` to navigate inside a stack folder

## Key-Value store

`lab.sh` has a key value store which can be used through the command line and inside of prepare
scripts to setup values for service stacks

**Inside `prepare.sh`**

```
load_lib kv

# ask user for value if it doesn't already exists
create_input_kv foo
export FOO=$(get_kv foo)
```

**From CLI**
```
lab.sh kv set foo bar
lab.sh kv get foo

# lab.sh kv help - display all commands
```

## Secrets store

`lab.sh` has a secret store which can be used through the command line and inside of prepare
scripts to setup values for service stacks

**Inside `prepare.sh`**

```
load_lib secrets

# ask user for value if it doesn't already exists
create_input_secret foo
export FOO=$(get_secret foo)

# auto generate value if it doesn't already exists
create_generate_secret bar
export FOO=$(get_secret bar)
```

**From CLI**
```
lab.sh secrets set foo bar
lab.sh secrets get foo

# lab.sh secrets help - display all commands
```
