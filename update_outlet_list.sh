#!/bin/bash

set -euo pipefail

readonly dw_dir="/c/temp/miele"
mkdir -p "$dw_dir"

readonly pdf_filename="MieleOutletPricelist.pdf"
readonly tmp_latest_filepath=$(mktemp)

curl -L "https://application.miele.co.uk/resources/pdf/$pdf_filename" \
    -o "$tmp_latest_filepath" -H "Cache-Control: no-cache" --no-keepalive

readonly old_filepath="$dw_dir/$pdf_filename"

# Run beyond compare against old & new files and wait for exit
function beyond_compare_diff() {
    set +e
    bcompare "$1" "$2" &
    set -e

    wait $!
}

if [[ -f "$old_filepath" ]]; then
    set +e
    diff "$old_filepath" "$tmp_latest_filepath"
    set -e

    if [[ $? -eq 0 ]]; then
        echo -e "\033[32mContents are identical; nothing to do.\033[0m"        
    else 
        echo -e "\033[31mContents differed; running bcompare\033[0m"
        beyond_compare_diff "$old_filepath" "$tmp_latest_filepath"
    fi    
else
    echo -e "\033[31mNo old file to diff against\033[0m"
    beyond_compare_diff "$old_filepath" "$tmp_latest_filepath"
fi

mv -f "$tmp_latest_filepath" "$old_filepath" 
