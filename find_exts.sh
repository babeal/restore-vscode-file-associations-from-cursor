#!/bin/bash

# Path to lsregister utility
lsregister_path="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister"

echo "Finding extensions associated with Cursor..."
echo "--------------------------------------------"

# Variables to track the state
is_cursor_bundle=false

# Read the lsregister dump line by line
$lsregister_path -dump | while IFS= read -r line; do
    if [[ "$line" =~ ^bundle: ]]; then
        # Check if the current bundle is Cursor
        if [[ "$line" =~ Cursor ]]; then
            is_cursor_bundle=true
        else
            is_cursor_bundle=false
        fi
    elif $is_cursor_bundle && [[ "$line" =~ ^bindings: ]]; then
        # Extract the extension(s) from the bindings line
        extensions=$(echo "$line" | grep -o "\.[a-z0-9]*")
        for ext in $extensions; do
            echo "$ext"
        done
        # Reset the state after processing bindings
        is_cursor_bundle=false
    fi
done