#!/bin/bash

folder=~/myfolder

# Proverka est' li papka (ne mamka)
if [ ! -d "$folder" ]; then
    echo "papki $folder poka netu. snachala nado zapustit script1.sh"
    exit 0
fi

# Skoka files v myfolder?
file_count=$(ls -1 "$folder" | wc -l)
echo "Number of files in myfolder: $file_count"

# 777 -> 664 (file2)
if [ -f "$folder/file2" ]; then
    chmod 664 "$folder/file2"
fi

# udalit' pustishki
find "$folder" -type f -empty -delete

# only first str
for file in "$folder"/*; do
    if [ -f "$file" ] && [ -s "$file" ]; then
        # first str to .tmp
        head -n 1 "$file" > "$file.tmp"
        # .tmp to original
        mv "$file.tmp" "$file"
    fi
done

echo "Ura! script2 srabotal!"
