x=$(cat scrp/inthandler/int.txt | sed s/"mon"//)

rm -rf scrp/inthandler/int.txt

echo $x > scrp/inthandler/int.txt