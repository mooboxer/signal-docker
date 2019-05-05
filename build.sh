#!/usr/bin/zsh

legacy=201905b
current=201905b

docker image rm moobox/signal-bash:${legacy}
docker image rm moobox/signal-bash

docker build -t moobox/signal-bash .
docker tag moobox/signal-bash moobox/signal-bash:${current}
