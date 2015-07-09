#!/bin/bash
#
# Start scrip for the DDS Daemon
#
# (C) 2014 INAETICS, <www.inaetics.org> - Apache License v2.

cd $(dirname $0)

#
# Config
#
DDS_DAEMONS_NAMESPACE="/inaetics/dds/daemons"
MAX_RETRY_ETCD_REPO=10
RETRY_ETCD_REPO_INTERVAL=5
UPDATE_INTERVAL=60
RETRY_INTERVAL=20
ETCD_TTL_INTERVALL=$((UPDATE_INTERVAL + 15))
LOG_DEBUG=true

#
# Libs
#
source etcdctl.sh

# Wraps a function call to redirect or filter stdout/stderr
# depending on the debug setting
#   args: $@ - the wrapped call
#   return: the wrapped call's return
_call () {
  if [ "$LOG_DEBUG" != "true"  ]; then
    $@ &> /dev/null
    return $?
  else
    $@ 2>&1 | awk '{print "[DEBUG] "$0}' >&2
    return ${PIPESTATUS[0]}
  fi
}

# Echo a debug message to stderr, perpending each line
# with a debug prefix.
#   args: $@ - the echo args
_dbg() {
  if [ "$LOG_DEBUG" == "true" ]; then
    echo $@ | awk '{print "[DEBUG] "$0}' >&2
  fi
}

# Echo a log message to stderr, perpending each line
# with a info prefix.
#   args: $@ - the echo args
_log() {
  echo $@ | awk '{print "[INFO] "$0}' >&2
}

echo "TODO" 
