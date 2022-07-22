#!/bin/sh

SYSTEM_NAME=Monitor_Kafka

isRunning() {
  [ ! -z $(docker compose ls -q) ] && return
}

start() {
  if ! isRunning
    then
        echo "Run $SYSTEM_NAME"
        docker compose up -d
    else
        echo "$SYSTEM_NAME is running"
  fi
}

stop() {
  if isRunning
    then
        echo "Stop $SYSTEM_NAME"
        docker compose down
    else
        echo "$SYSTEM_NAME is not running"
  fi
}

restart() {
  if isRunning
    then
      stop
      start
    else
      echo "$SYSTEM_NAME is not running"
  fi
}

status() {
  if isRunning
    then
      docker compose ps
    else
      echo "$SYSTEM_NAME is not running"
  fi
}

logs() {
  if isRunning
    then
      docker compose logs
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
    logs
  ;;
esac
