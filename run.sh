#!/bin/bash

if [ "$1" = "clean" ]; then
  docker-compose -f compose.yml stop
  ret=$?
  if [ $ret -ne 0 ]; then
    exit $ret
  fi
  docker-compose -f compose.yml rm -f
  ret=$?
  if [ $ret -ne 0 ]; then
    exit $ret
  fi
elif [ "$1" = "deploy" ]; then
  docker-compose -f compose.yml pull
  ret=$?
  if [ $ret -ne 0 ]; then
    exit $ret
  fi
  docker-compose -f compose.yml up -d
  ret=$?
  if [ $ret -ne 0 ]; then
    exit $ret
  fi
else
  echo "Invalid argument: $1"
  ret=1
fi

exit $ret
