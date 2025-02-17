#!/bin/bash

# Directory to monitor
CORPORA_DIR="/Users/chim/Working/Thesis/Readings/corpora"

# Path to the run script
RUN_SCRIPT="/Users/chim/Working/Thesis/Readings/src/run.sh"

# Function to process a directory
process_directory() {
    local dir="$1"
    local mov_file=""
    local text_file=""

    # Check for .mov file and corresponding text file
    for file in "$dir"/*; do
        if [[ -f "$file" ]]; then
            if [[ "$file" == *.mov ]]; then
                mov_file="$file"
                text_file="${file%.mov}.txt"
            fi
        fi
    done

    # If there's a .mov file but no corresponding text file, process it
    if [[ -n "$mov_file" && ! -f "$text_file" ]]; then
        echo "Processing $mov_file"
        bash "$RUN_SCRIPT" "$mov_file"
        echo "Finished processing $mov_file"
    fi
}

# Main loop
while true; do
    while IFS= read -r -d '' dir; do
        process_directory "$dir"
    done < <(find "$CORPORA_DIR" -type d -print0)
    
    echo "Completed one full scan of the directory. Waiting for 60 seconds before the next scan..."
    sleep 60  # Wait for 60 seconds before the next iteration
done