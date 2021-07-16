#!/usr/bin/bash
set -o pipefail

if [ -z $MAX_MEM ]; then
    MAX_MEM=2048m
fi

# start a detached tmux session if not having one
tmux has-session -t server
if [ $? -ne 0 ]; then
    tmux new-session -d -c {{ minecraft_path }} -t server
fi

# start the server in tmux session if server is not running
ps ux | grep java | grep -v grep
if [ $? -ne 0 ]; then
    tmux send-key \
        "java -Xmx${MAX_MEM} -jar server.jar nogui" \
        C-m # <C-m> is return key
fi
