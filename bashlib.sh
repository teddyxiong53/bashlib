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

# Example initialization for associative arrays (dictionaries)
declare -A dict
