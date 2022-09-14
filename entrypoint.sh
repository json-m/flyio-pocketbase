#!/bin/ash
set -e
run() {
  "$@" &
  p="$!"
  trap "kill -SIGTERM $p" SIGINT SIGTERM
  while kill -0 $p>/dev/null 2>&1;do
    wait
  done
}
run $@

