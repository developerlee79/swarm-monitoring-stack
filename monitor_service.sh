#!/bin/sh

SYSTEM_NAME=Monitor_Stack
STACK_NAME=monitor_stack
STACK_NETWORK=monitor_network
ELASTIC_VERSION=8.2.0
NODE_LIST=$(echo $(docker node ls --format "{{ .Hostname }}") | sed "s/\s/,/g")

isRunning() {
   [ ! -z $(docker stack ls --format "{{ .Name }}") ] && return
}

start() {
  if ! isRunning
    then
        echo "Run $SYSTEM_NAME"
        export ELASTIC_VERSION=$ELASTIC_VERSION
        export NODE_LIST=$NODE_LIST
        if [ -z "$(docker network ls | grep $STACK_NETWORK)" ]
          then
             docker network create --driver overlay --attachable $STACK_NETWORK
        fi
        docker stack deploy --compose-file docker-compose.yml $STACK_NAME
    else
        echo "$SYSTEM_NAME is running"
  fi
}

stop() {
  if isRunning
    then
        echo "Stop $SYSTEM_NAME"
        docker stack rm $STACK_NAME
    else
        echo "$SYSTEM_NAME is not running"
  fi
}

restart() {
  if isRunning
    then
      stop
      echo "Wating 3 sec..."
      sleep 3s
      start
    else
      echo "$SYSTEM_NAME is not running"
  fi
}

status() {
  if isRunning
    then
      docker service ls
    else
      echo "$SYSTEM_NAME is not running"
  fi
}

logs() {
 if isRunning
  then
    docker service logs "${STACK_NAME}"_$1
  else
    echo "$SYSTEM_NAME is not running"
 fi
}

update() {
  if isRunning
   then
     docker service update --force --update-failure-action "rollback" "${STACK_NAME}"_$1
   else
     echo "$SYSTEM_NAME is not running"
  fi
}

case $1 in
  start)
    start
  ;;
  stop)
    stop
  ;;
  restart)
    restart
  ;;
  status)
    status
  ;;
  logs)
    logs $2
  ;;
  update)
    update $2
  ;;
esac
