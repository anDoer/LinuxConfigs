#!/bin/bash

MAX_BRIGHTNESS_PATH='/sys/class/backlight/intel_backlight/max_brightness'
BRIGHTNESS_PATH='/sys/class/backlight/intel_backlight/brightness'

MAX_BRIGHTNESS=`cat $MAX_BRIGHTNESS_PATH`
CURR_BRIGHTNESS=`cat $BRIGHTNESS_PATH`

MIN_BRIGHTNESS=17
BRIGHTNESS_STEP=263 

if [[ $1 == "up" ]]
then
    SUM=$(($CURR_BRIGHTNESS + $BRIGHTNESS_STEP))
    if (( $SUM < $MAX_BRIGHTNESS))
    then
        # Set new brightness 
        tee $BRIGHTNESS_PATH <<< $SUM > /dev/null
    fi
elif [[ $1 == "down" ]]
then
    DIFF=$(($CURR_BRIGHTNESS - $BRIGHTNESS_STEP))
    
    if (( $DIFF > $MIN_BRIGHTNESS ))
    then
        tee $BRIGHTNESS_PATH <<< $DIFF > /dev/null
    fi
fi
