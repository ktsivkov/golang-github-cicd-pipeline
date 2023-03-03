#!/bin/bash
# Declare an exit code variable, in order to fail in case any untested files were found
exit_code=0

# Read the excluded files into an array
mapfile -t excluded_files < .coverignore

# Function to check if a file or directory is excluded
function is_excluded() {
  local file=$1
  for excluded_file in "${excluded_files[@]}"; do
    if [[ -n "$excluded_file"       && (
      "$file" == "$excluded_file"   ||
      "$file/" == "$excluded_file"  ||
      "$file" == $excluded_file     ||
      ( $excluded_file == *"/"      && $file == "$excluded_file"* )
    ) ]]; then
      return 0
    fi
  done
  return 1
}

# Loop over all directories and files
while IFS= read -r -d '' file; do
  # Check if the file was excluded, and if it is a .go file without a matching _test.go file
  if ! is_excluded "$file" && [[ "$file" == *.go && ! "$file" == *_test.go && ! -f "${file%.*}_test.go" ]]; then
    exit_code=1
    echo "ERROR! File $file does not have a matching _test.go file"
  fi
done < <(find . -type f -print0)

exit $exit_code
