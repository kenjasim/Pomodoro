#!/bin/bash
if [ $# -ne 4 ]; then
    echo "Start a pomodoro timer"
    echo ""
    echo "usage: pomodoro [number of runs] [work time] [break time] [long break time]"

    exit 1
fi

work=$(($2 * 60))
short_break=$(($3 * 60))
long_break=$(($4 * 60))

echo $work $short_break $long_break

short_break_run(){
    sleep $work && notify-send "Pomodoro Timer" "Break time (short break)"
    sleep $short_break && notify-send "Pomodoro Timer" "Back to work"
}

long_break_run(){
    sleep $work && notify-send "Pomodoro Timer" "Break time (long break)"
    sleep $long_break && notify-send "Pomodoro Timer" "Run finished"
}

pomodoro_cycle(){
    # Notify the user that the timer is starting
    notify-send "Pomodoro Timer" "Starting pomodoro timer"

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