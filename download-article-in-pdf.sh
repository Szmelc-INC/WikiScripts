#!/bin/bash
clear
echo "Usage: ./$0 Article_title" 
echo "Example: bash $0 Machine_Learning"
curl https://en.wikipedia.org/api/rest_v1/page/pdf/$1 --output $1.pdf
