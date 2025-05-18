#!/bin/bash
if [ ! -d ~/myfolder ]; then
    exit 0
fi
echo "Number of files in myfolder: $(ls -1 ~/myfolder | wc -l)"
if [ -f ~/myfolder/file2 ]; then
    chmod 664 ~/myfolder/file2
fi
find ~/myfolder -type f -empty -delete
for file in ~/myfolder/*; do
    if [ -f "$file" ] && [ -s "$file" ]; then
        head -n 1 "$file" > "$file.tmp"
        mv "$file.tmp" "$file"
    fi
done

