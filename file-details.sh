#!/bin/bash
clear && echo "===== File details parser =====" && echo "Usage: $0 filename" && echo "===============================" && echo ""
file $1 > out
sed --in-place 's/,/\n/g' out
sed --in-place 's/:/\n/g' out
echo "File: [$1]" > out2
cat out >> out2
clear && cat out2
