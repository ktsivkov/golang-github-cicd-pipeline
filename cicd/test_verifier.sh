#!/bin/bash

ignore_file=".coverignore"
untested_files=()

# Read the .coverignore file for this directory into an array
ignore_list=()
if [[ -f "$ignorefile" ]]; then
  mapfile -t ignore_list < "$ignorefile"
fi

count_slashes() {
  return $(echo "$1" | tr -cd '/' | wc -c)
}

process_directory() {
  local dir="$1"

  # Loop through each file or directory in the directory
  for entry in "$dir"/*; do
    # Check if the file or directory matches any of the ignoring patterns
    for pattern in ${ignore_list[@]}; do
      if [[ ${pattern: -1} == "/" ]]; then
        pattern="${pattern%/*}"
      fi
      # Check if the entry matches the file pattern
      if [[ ( "$entry" == "$pattern" && $(count_slashes "$entry") -eq $(count_slashes "$pattern") ) ||
            "$dir" == "$pattern"  ]]; then
        continue 2 # An ignoring pattern was matched, so we ignore
      fi
    done

    # If the entry is a directory, recursively process it
    if [[ -d $entry ]]; then
      process_directory "$entry"
      continue
    fi

    if [[ $entry =~ \.go$ && ! $entry =~ _test\.go$ && ! -f ${entry%.*}_test.go ]]; then
      untested_files+=("$entry")
    fi
  done
}

# Start processing the root directory
process_directory "."

if [[ ${#untested_files[@]} -eq 0 ]]; then
  exit 0
fi

for file in "${untested_files[@]}"; do
  echo "No tests found for $file"
done
exit 1