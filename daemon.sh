#!/bin/bash

PIDPATH="/var/run/autoblock.pid"
PID=""

function get_pid {
   PID="$(cat $PIDPATH)"
}

function stop {
   get_pid
   if [ -z $PID ]; then
      echo "server is not running."
      exit 1
   else
      echo -n "Stopping server.."
      kill -9 $PID
      rm $PIDPATH
      sleep 1
      echo ".. Done."
   fi
}


function start {
   get_pid
   if [ -z $PID ]; then
      echo  "Starting server.."
      ./autoblock.sh &
      get_pid
      echo "Done. PID=$PID"
   else
      echo "server is already running, PID=$PID"
   fi
}

function restart {
   echo  "Restarting server.."
   get_pid
   if [ -z $PID ]; then
      start
   else
      stop
      sleep 5
      start
   fi
}


function status {
   get_pid
   if [ -z  $PID ]; then
      echo "Server is not running."
      exit 1
   else
      echo "Server is running, PID=$PID"
   fi
}

case "$1" in
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
   *)
      echo "Usage: $0 {start|stop|restart|status}"
esac
