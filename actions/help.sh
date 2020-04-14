echo "lab.sh <ACTION>"

echo ""
echo "ACTIONS:"
for CURRENT_DIR in "$TOOLS_ROOT/actions/"*; do
(
  ACTION_NAME="$(basename $CURRENT_DIR | cut -d'.' -f1)"
  echo "$ACTION_NAME"
)
done
