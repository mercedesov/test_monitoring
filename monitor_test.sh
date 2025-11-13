
#!/bin/bash

LOGFILE="/var/log/monitoring.log"
PROCESS_NAME="test"
URL="https://test.com/monitoring/test/api"

pid=$(pgrep -x $PROCESS_NAME)

PIDFILE="/var/run/${PROCESS_NAME}_pid"

if [ -z "$pid" ]; then
    exit 0
fi

if [ -f "$PIDFILE" ]; then
    old_pid=$(cat $PIDFILE)
else
    old_pid=""
fi

if [ "$pid" != "$old_pid" ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') Process $PROCESS_NAME restarted with PID $pid" >> $LOGFILE
    echo $pid > $PIDFILE
fi

if ! curl --silent --fail --max-time 10 $URL > /dev/null; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') Monitoring server is not available" >> $LOGFILE
fi
