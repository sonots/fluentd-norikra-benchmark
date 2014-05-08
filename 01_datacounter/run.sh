SCRIPT_DIR=$(dirname $0)
tmux new-window "bundle exec fluentd -c $SCRIPT_DIR/agent.conf"
tmux new-window "bundle exec dummer -c dummer.conf"
