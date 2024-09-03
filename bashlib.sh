#!/bin/bash

# bashlib.sh - A simple shell library with basic utilities and data structures

############# Log function #############
log() {
    local level=$1
    shift
    local message="$@"
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    if [[ "$level" == "ERROR" ]] || [[ "$LOG_LEVEL" == "DEBUG" ]] || [[ "$LOG_LEVEL" == "$level" ]]; then
        echo "[$timestamp] [$level] $message"
    fi
}

# Log to file
log_to_file() {
    local logfile=$1
    local level=$2
    shift 2
    local message="$@"
    log "$level" "$message" >> "$logfile"
}

############# String functions #############
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



############## Array functions #############
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

############## Loop and condition tools #############
foreach_array() {
    local arr=("$@")
    for element in "${arr[@]}"; do
        echo "$element"
    done
}


############## Dict (associative array) functions#############
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

############## File operations#############
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

############## Error handling #############
trap_error() {
    local err="$?"
    log "ERROR" "An error occurred on line $1 with exit code $err."
    exit $err
}

trap 'trap_error $LINENO' ERR

############## Parallel execution#############
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

# Concurrent task execution with results collection
run_tasks_concurrently() {
    local tasks=("$@")
    local results=()
    for task in "${tasks[@]}"; do
        eval "$task" &
        pids+=($!)
    done
    for pid in "${pids[@]}"; do
        wait "$pid"
        results+=($?)
    done
    echo "${results[@]}"
}


############### Argument parsing##############
parse_args() {
    local ARGUMENTS=("$@")
    declare -A args
    while [[ $# -gt 0 ]]; do
        case $1 in
            --*=*)
                key="${1%%=*}"
                value="${1#*=}"
                args["$key"]="$value"
                shift
                ;;
            --*)
                key="$1"
                value="$2"
                args["$key"]="$value"
                shift 2
                ;;
            *)
                shift
                ;;
        esac
    done
    echo "${args[@]}"
    export ARGS=("${args[@]}")
}
################ config file ################
# INI file parsing
parse_ini_file() {
    local file=$1
    declare -A config
    while IFS='= ' read -r key value; do
        if [[ $key != \[*] && $key != "" ]]; then
            config["$key"]="$value"
        fi
    done < "$file"
    echo "${config[@]}"
    export CONFIG=("${config[@]}")
}

################ Process management###############
process_is_running() {
    local pid=$1
    if ps -p "$pid" > /dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

kill_process() {
    local pid=$1
    if process_is_running "$pid"; then
        kill "$pid"
        echo "Process $pid terminated"
    else
        echo "Process $pid is not running"
    fi
}

################# System resource monitoring################
get_cpu_usage() {
    local usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
    echo "$usage"
}

get_memory_usage() {
    local usage=$(free -m | grep Mem | awk '{printf "%.2f", $3/$2 * 100.0}')
    echo "$usage%"
}

################## Network tools#################
check_connectivity() {
    local host=$1
    if ping -c 1 "$host" > /dev/null 2>&1; then
        echo "$host is reachable"
    else
        echo "$host is not reachable"
    fi
}

download_file() {
    local url=$1
    local dest=$2
    if curl -o "$dest" "$url"; then
        echo "Downloaded $url to $dest"
    else
        echo "Failed to download $url"
    fi
}

# HTTP GET request
http_get() {
    local url=$1
    curl -s "$url"
}

# HTTP POST request
http_post() {
    local url=$1
    local data=$2
    curl -s -X POST -H "Content-Type: application/json" -d "$data" "$url"
}


# Progress bar
progress_bar() {
    local progress=$1
    local width=50
    local completed=$((progress * width / 100))
    local remaining=$((width - completed))
    printf "["
    printf "%0.s#" $(seq 1 $completed)
    printf "%0.s " $(seq 1 $remaining)
    printf "] %s%%\r" "$progress"
}



# Random number generation
random_int() {
    local min=$1
    local max=$2
    echo $((RANDOM % (max - min + 1) + min))
}

# Example initialization for associative arrays (dictionaries)
declare -A dict
