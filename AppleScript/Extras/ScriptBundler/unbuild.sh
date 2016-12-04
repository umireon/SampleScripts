#!/bin/bash
if [[ $1 != -f ]]; then
    echo Specify -f to proceed
    echo This script will overwrite the content under the current directory.
    exit 1
fi

## configuration
SCRIPT_NAME=SampleHookingScript
PREFIX=~/"Library/Application Scripts/com.coteditor.CotEditor"

install_dir="$PREFIX/$SCRIPT_NAME.scptd"

## decompile the main script
main_scpt="$install_dir/Contents/Resources/Scripts/main.scpt"
if [ -e main.applescript ]; then
    osadecompile "$main_scpt" > main.applescript
else
    osadecompile "$main_scpt" > main.js
fi

## decompile script libraries
shopt -s nullglob
resources_dir="$install_dir/Contents/Resources"
for name in "Script Libraries"/*.js; do
    osadecompile "$resources_dir/${name%.js}.scpt" > "$name"
done
for name in "Script Libraries"/*.applescript; do
    osadecompile "$resources_dir/${name%.applescript}.scpt" > "$name"
done
