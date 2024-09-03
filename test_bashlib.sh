#!/bin/bash

# Load the bashlib.sh library
source ./bashlib.sh

# Test log function (already demonstrated in demo.sh)

# Test string_replace
test_string_replace() {
    local result
    result=$(string_replace "Hello World" "World" "Bash")
    if [ "$result" == "Hello Bash" ]; then
        echo "string_replace passed"
    else
        echo "string_replace failed"
    fi
}

# Test string_split
test_string_split() {
    local result
    result=($(string_split "a,b,c" ","))
    if [ "${result[0]}" == "a" ] && [ "${result[1]}" == "b" ] && [ "${result[2]}" == "c" ]; then
        echo "string_split passed"
    else
        echo "string_split failed"
    fi
}

# Test string_join
test_string_join() {
    local result
    result=$(string_join "-" "a" "b" "c")
    if [ "$result" == "a-b-c" ]; then
        echo "string_join passed"
    else
        echo "string_join failed"
    fi
}

# Test foreach_array
test_foreach_array() {
    local arr=("one" "two" "three")
    local output
    output=$(foreach_array "${arr[@]}")
    if [ "$output" == $'one\ntwo\nthree' ]; then
        echo "foreach_array passed"
    else
        echo "foreach_array failed"
    fi
}

# Test check_empty
test_check_empty() {
    if check_empty ""; then
        echo "check_empty (empty) passed"
    else
        echo "check_empty (empty) failed"
    fi

    if ! check_empty "not empty"; then
        echo "check_empty (not empty) passed"
    else
        echo "check_empty (not empty) failed"
    fi
}

# Test read_file and write_file
test_file_operations() {
    local test_file="test_file.txt"
    local test_content="Hello Bash"
    write_file "$test_file" "$test_content"
    local result
    result=$(read_file "$test_file")
    if [ "$result" == "$test_content" ]; then
        echo "file_operations passed"
    else
        echo "file_operations failed"
    fi
    rm "$test_file"  # Clean up
}

# Test trap_error by forcing an error
test_trap_error() {
    (exit 1)  # Simulate an error
    if [ $? -ne 0 ]; then
        echo "trap_error passed"
    else
        echo "trap_error failed"
    fi
}

# Test run_parallel
test_run_parallel() {
    local cmds=("sleep 1" "echo 'Task 2'" "echo 'Task 3'")
    local output
    output=$(run_parallel "${cmds[@]}")
    if [ "$(echo "$output" | wc -l)" -eq 2 ]; then
        echo "run_parallel passed"
    else
        echo "run_parallel failed"
    fi
}

# Run all tests
test_string_replace
test_string_split
test_string_join
test_foreach_array
test_check_empty
test_file_operations
test_trap_error
test_run_parallel
