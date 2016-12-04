#!/bin/bash
## configuration
SCRIPT_NAME=SampleHookingScript
PREFIX=~/"Library/Application Scripts/com.coteditor.CotEditor"

install_dir="$PREFIX/$SCRIPT_NAME.scptd"

## remove everything
rm -rf "$install_dir"

## install Info.plist
mkdir -p "$install_dir/Contents"
install -m 644 Info.plist "$install_dir/Contents/Info.plist"

## compile the main script
mkdir -p "$install_dir/Contents/Resources/Scripts"
main_scpt="$install_dir/Contents/Resources/Scripts/main.scpt"
if [ -e main.applescript ]; then
    osacompile -l AppleScript -o "$main_scpt" main.applescript
else
    osacompile -l JavaScript -o "$main_scpt" main.js
fi

## compile script libraries
mkdir -p "$install_dir/Contents/Resources/Script Libraries"
shopt -s nullglob
resources_dir="$install_dir/Contents/Resources"
for name in "Script Libraries"/*.js; do
    osacompile -l JavaScript -o "$resources_dir/${name%.js}.scpt" "$name"
done
for name in "Script Libraries"/*.applescript; do
    osacompile -l AppleScript -o "$resources_dir/${name%.applescript}.scpt" "$name"
done
