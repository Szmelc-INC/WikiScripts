#!/bin/bash
# Fetch random Wikipedia Article
wget "https://en.wikipedia.org/wiki/Special:Random" -o out
cat out | grep "Location: " > out2
sed --in-place 's/Location: /https:/g' out2
curl $(cat out2) > out3.html
cat out3.html | grep "<title>" > out3-title.txt
sed --in-place 's/<title>//g' out3-title.txt
sed --in-place 's\</title>\\g' out3-title.txt
sed --in-place 's\ - Wikipedia\\g' out3-title.txt
sed --in-place 's\ \_\g' out3-title.txt
export OUT3T=$(cat out3-title.txt)
touch $OUT3T.html
cp out3.html $OUT3T.html
mv $OUT3T.html Articles/$OUT3T.html
bash download-article-in-pdf.sh $OUT3T
rm .pdf
mv *.pdf Articles/
touch out out2 out3.html out3-title.txt out.html out2.html out.txt Special:Random echo
rm out out2 out3.html out3-title.txt out.html out2.html out.txt Special:Random echo
clear
echo "Fetched: $OUT3T"
stat Articles/$OUT3T.html
