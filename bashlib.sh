#!/bin/bash

# bashlib.sh - A simple shell library with basic utilities and data structures

# Log function
log() {
    local level=$1
    shift
    local message="$@"
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] [$level] $message"
}

# String functions
string_replace() {
    local str=$1
    local search=$2
    local replace=$3
    echo "${str//$search/$replace}"
}

string_split() {
    local str=$1
    local delimiter=$2
    IFS="$delimiter" read -ra ADDR <<< "$str"
    echo "${ADDR[@]}"
}

string_join() {
    local delimiter=$1
    shift
    local arr=("$@")
    local joined=$(IFS="$delimiter"; echo "${arr[*]}")
    echo "$joined"
}



# Array functions
array_push() {
    eval "$1+=(\"$2\")"
}


array_pop() {
    eval "unset '$1[\${#$1[@]}-1]'"
}

array_get() {
    eval "echo \${$1[$2]}"
}

array_length() {
    eval "echo \${#$1[@]}"
}

# Loop and condition tools
foreach_array() {
    local arr=("$@")
    for element in "${arr[@]}"; do
        echo "$element"
    done
}


# Dict (associative array) functions
dict_set() {
    eval "$1[\"$2\"]=\"$3\""
}

dict_get() {
    eval "echo \${$1[\"$2\"]}"
}

dict_keys() {
    eval "echo \${!$1[@]}"
}

dict_values() {
    eval "echo \${$1[@]}"
}


check_empty() {
    if [ -z "$1" ]; then
        return 0  # true
    else
        return 1  # false
    fi
}

# File operations
read_file() {
    local file_path=$1
    while IFS= read -r line; do
        echo "$line"
    done < "$file_path"
}

write_file() {
    local file_path=$1
    local content=$2
    echo "$content" > "$file_path"
}

# Error handling
trap_error() {
    local err="$?"
    log "ERROR" "An error occurred on line $1 with exit code $err."
    exit $err
}

trap 'trap_error $LINENO' ERR

# Parallel execution
run_parallel() {
    local cmds=("$@")
    local pids=()
    for cmd in "${cmds[@]}"; do
        eval "$cmd" &
        pids+=($!)
    done
    for pid in "${pids[@]}"; do
        wait "$pid"
    done
}

# Example initialization for associative arrays (dictionaries)
declare -A dict
