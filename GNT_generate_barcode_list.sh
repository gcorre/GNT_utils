#!/bin/bash

# Check if a pattern is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <pattern>"
    echo "Example: $0 NNWNNWNN"
    exit 1
fi

pattern=$1

# Define the IUPAC nucleotide codes
declare -A iupac_codes=(
    ["N"]="{A,T,C,G}"
    ["W"]="{A,T}"
    ["S"]="{C,G}"
    ["M"]="{A,C}"
    ["K"]="{G,T}"
    ["R"]="{A,G}"
    ["Y"]="{C,T}"
    ["B"]="{C,G,T}"
    ["D"]="{A,G,T}"
    ["H"]="{A,C,T}"
    ["V"]="{A,C,G}"
    ["A"]="A"
    ["T"]="T"
    ["C"]="C"
    ["G"]="G"
)

# Replace each character in the pattern with the corresponding brace expansion
expanded_pattern=""
for ((i=0; i<${#pattern}; i++)); do
    char="${pattern:$i:1}"
    if [[ -n "${iupac_codes[$char]}" ]]; then
        expanded_pattern+="${iupac_codes[$char]}"
    else
        echo "Invalid character in pattern: $char"
        exit 1
    fi
done
expanded_pattern=$(echo $expanded_pattern"\\\n")

# Use brace expansion to generate all possible sequences
eval echo -e  $expanded_pattern | tr -d ' ' > sequences_pattern.txt

echo "All possible nucleotide sequences following the pattern $pattern have been generated and saved to sequences_pattern.txt."
