SCRIPT_DIR=$(dirname $0)
if [ -n "$1" ]; then
  RATE="-r $1"
fi
# tmux new-window "bash start-norikra.sh"
bash $SCRIPT_DIR/query.sh
tmux new-window "bundle exec fluentd -c $SCRIPT_DIR/receiver.conf"
tmux new-window "bundle exec fluentd -c $SCRIPT_DIR/agent.conf"
tmux new-window "bundle exec dummer -c dummer.conf $RATE"
