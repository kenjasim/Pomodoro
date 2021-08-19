#!/bin/bash
########################################################
# Run a work session with pomodoro
# Author: Kenan Jasim
########################################################

# Check if all the vars have been put in
if [ $# -ne 4 ]; then
    echo "Start a pomodoro timer"
    echo ""
    echo "usage: pomodoro [number of runs] [work time] [break time] [long break time]"

    exit 1
fi

work=$(($2 * 60))
short_break=$(($3 * 60))
long_break=$(($4 * 60))


send_notification(){
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        notify-send "Pomodoro" $1
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        osascript -e 'display notification "'"$1"'" with title "Pomodoro"'
    else
        echo "OS not supported"
        exit 1
    fi
}

short_break_run(){
    sleep $work && send_notification "Break time (short break)"
    sleep $short_break && send_notification "Back to work"
}

long_break_run(){
    sleep $work && send_notification "Break time (long break)"
    sleep $long_break && send_notification "Run finished"
}

pomodoro_cycle(){
    echo "Work time: ${work}m Break time: ${short_break}m Long Break time: ${long_break}m"

    send_notification "Work time: ${work}m Break time: ${short_break}m Long Break time: ${long_break}m"

    # Start the pomodoro cycle
    for i in {1..3}
    do
        short_break_run
    done
    
    long_break_run
    
}

for i in {1..$1}
do
    pomodoro_cycle
done