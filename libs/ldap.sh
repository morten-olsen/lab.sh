load_lib kv
load_lib secrets
load_lib stack

LDAP_STACK=$(get_kv ldap_stack)

function ldap_create_app {
  (
    NAME="$1"
    PASS="$2"
    load_stack_info $LDAP_STACK
    LDAP_PASS=$(get_secret ldap_pass)
    BASE_DN=$(get_kv ldap_base_dn)
    ENCRYPTED=$(run_stack $STACK_NAME docker-compose exec ldap slappasswd -s "$PASS")
    CMD="
dn: cn=$NAME,ou=Applications,$BASE_DN
changetype: add
cn: $NAME
objectclass: organizationalRole
objectclass: top
objectclass: simpleSecurityObject
userpassword: $ENCRYPTED
"
    echo "$CMD" | run_stack $STACK_NAME docker-compose exec -T ldap ldapmodify -w "$LDAP_PASS" -x -D "cn=admin,$BASE_DN"
  )
}
