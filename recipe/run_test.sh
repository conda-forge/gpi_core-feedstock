#!/bin/bash
set -x

if [ "$(uname)" == "Darwin" ]; then
    OUTPUT_1=`gpi --nogui TestNetwork.net`
    OUTPUT=`echo $OUTPUT_1 | grep "gpi.canvasGraph:383"`
    if [ -z "$OUTPUT" ]; then
        echo "Test Network Failed! Output was not successful completion of network" 1>&2
        exit 1
    else
        echo "Test Network Executed Successfully!"
    fi
fi

if [ "$(uname)" == "Linux" ]; then
    export DISPLAY=localhost:1.0
    OUTPUT_1=`Display=localhost:1.0 xvfb-run -a bash -c "gpi --nogui TestNetwork.net"`
    OUTPUT=`echo $OUTPUT_1 | grep "gpi.canvasGraph:383"`
    if [ -z "$OUTPUT" ]; then
        echo "Test Network Failed! Output was not successful completion of network" 1>&2
        exit 1
    else
        echo "Test Network Executed Successfully!"
    fi
fi
