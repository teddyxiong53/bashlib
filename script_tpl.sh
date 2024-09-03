#!/bin/bash

# Load the bashlib.sh library
source ./bashlib.sh

# Default configurations (can be overridden by command-line arguments)
LOG_LEVEL="INFO"
CONFIG_FILE=""
DEBUG_MODE=0

# Usage function
usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -c, --config <file>    Specify the configuration file"
    echo "  -l, --log-level <level> Set the log level (DEBUG, INFO, WARN, ERROR)"
    echo "  -d, --debug            Enable debug mode"
    echo "  -h, --help             Display this help message"
    exit 1
}

# Parse command-line arguments
parse_args() {
    while (( "$#" )); do
        case "$1" in
            -c|--config)
                CONFIG_FILE=$2
                shift 2
                ;;
            -l|--log-level)
                LOG_LEVEL=$2
                shift 2
                ;;
            -d|--debug)
                DEBUG_MODE=1
                shift
                ;;
            -h|--help)
                usage
                ;;
            --) # End of all options
                shift
                break
                ;;
            -*|--*=) # Unsupported flags
                echo "Error: Unsupported flag $1" >&2
                usage
                ;;
            *) # Preserve positional arguments
                shift
                ;;
        esac
    done
}

# Main function
main() {
    log "INFO" "Starting script..."

    # Parse command-line arguments
    parse_args "$@"

    # Load configuration file if provided
    if [ -n "$CONFIG_FILE" ]; then
        if [ -f "$CONFIG_FILE" ]; then
            log "INFO" "Loading configuration from $CONFIG_FILE"
            source "$CONFIG_FILE"
        else
            log "ERROR" "Configuration file $CONFIG_FILE not found"
            exit 1
        fi
    fi

    # Enable debug mode if specified
    if [ "$DEBUG_MODE" -eq 1 ]; then
        set -x
        log "DEBUG" "Debug mode enabled"
    fi

    #============== add your code here============
    echo "hello world"
    echo $aa $bb
    #============== add your code here============

    # Exit the script
    log "INFO" "Script completed successfully"
    exit 0
}

# Entry point of the script
main "$@"
