#!/bin/bash

# Load the bashlib.sh library
source ./bashlib.sh

# Logging examples
log "INFO" "Starting the demo script..."
log "ERROR" "This is an error message."

# Array examples
array_push my_array "element1"
array_push my_array "element2"
array_push my_array "element3"
log "INFO" "Array length: $(array_length my_array)"
log "INFO" "First element: $(array_get my_array 0)"

array_pop my_array
log "INFO" "Array length after pop: $(array_length my_array)"

# Dict examples
dict_set dict "key1" "value1"
dict_set dict "key2" "value2"
log "INFO" "Value for key1: $(dict_get dict key1)"
log "INFO" "All keys: $(dict_keys dict)"
log "INFO" "All values: $(dict_values dict)"

log "INFO" "Demo script completed."
