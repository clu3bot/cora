x=$(cat int.txt | sed s/"mon"//)

rm -rf int.txt

echo $x > int.txt