#!/bin/bash

"./cicd/test_verifier.sh" || exit 1

coverage_threshold=${COVERAGE_THRESHOLD-80} # percentage /must be an integer/

coverage_file="coverage.out"

# Remove the previous coverage file if any leftovers
if [ -f $coverage_file ] ; then
    rm $coverage_file
fi

# Run Tests with coverage profiler enabled, and generate an output file
go test ./... -coverprofile=$coverage_file || ([ -e $coverage_file ] && rm $coverage_file)

# Confirm that the coverage file was created successfully
if [ ! -f $coverage_file ] ; then
    echo "ERROR! No coverage to analyze"
    exit 1
fi

# Get the test coverage i.e. 100% (string)
coverage=$(go tool cover -func $coverage_file | grep total | awk '{print $3}')

# Separator
echo "---"

# Remove the test coverage profiler output file
rm $coverage_file

# Remove the percentage symbol
coverage_size=${coverage%"%"}

# Parse to int (multiplied by 100)
coverage_size=$(awk '{print $1 * 100}' <<<"${coverage_size}")

if (( coverage_size < $coverage_threshold*100 )); then
    echo "ERROR! Current test coverage of $coverage is less than the threshold of $coverage_threshold%"
    exit 1
fi

echo "OK! Tests succeeded with coverage of a" $coverage
exit 0
