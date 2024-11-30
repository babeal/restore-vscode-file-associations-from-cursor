# Copyright 2024 brandt
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     https://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#!/bin/bash

# Path to lsregister utility
lsregister_path="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister"
vscode_bundle="com.microsoft.VSCode"

echo "Updating file extensions associated with Cursor to open with Visual Studio Code..."
echo "--------------------------------------------------------------------------------"

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
            echo "Processing extension: $ext"
            duti -s "$vscode_bundle" "${ext#.}" all
        done
        # Reset the state after processing bindings
        is_cursor_bundle=false
    fi
done

killall Finder
killall Dock

echo "Update complete!"