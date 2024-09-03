#!/bin/bash

# Load the bashlib.sh library
source ./bashlib.sh

# Test progress bar
test_progress_bar() {
    echo "Testing progress bar..."
    for i in $(seq 0 100); do
        progress_bar $i
        sleep 0.001
    done
    echo -e "\nProgress bar test completed"
}
test_progress_bar
check_connectivity "8.8.8.8"