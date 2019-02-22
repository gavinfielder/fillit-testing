#!/bin/sh

compare() {
	$1 ttmnfile > out1.txt
	$2 ttmnfile > out2.txt
	DIFF=`diff out1.txt out2.txt`
	NUMDIFF=${#DIFF}
	if [ $NUMDIFF -gt 0 ]
	then
		echo "Diff detected:" >> diffs.txt
		echo "Input file:" >> diffs.txt
		cat ttmnfile >> diffs.txt
		echo "Results from: $1" >> diffs.txt
		cat out1.txt >> diffs.txt
		echo "Results from: $2" >> diffs.txt
		cat out2.txt >> diffs.txt
		echo "" >> diffs.txt
		echo "Discrepancy logged. See diffs.txt for details.  Compared with:  $2"
	else
		echo "ok:   $1  vs  $2  with size=$SIZE"
	fi
}

random_size() {
	MAX_SIZE=8
	NUM=$(($RANDOM % $MAX_SIZE + 1))
	return $NUM
}

next_index() {
	return $((($1 + 1) % $2))
}

OUR_FILLIT=./our-fillit/fillit
NUM_VALID_FILLITS=6
VALID_FILLITS=(./validated-fillits/Itokoyamato/fillit
			   ./validated-fillits/ValeriiaMur/fillit
			   ./validated-fillits/davhojt/fillit
			   ./validated-fillits/jgengo/fillit
			   ./validated-fillits/oanamateiflorin/fillit
			   ./validated-fillits/rchiorea/fillit)

			   # ./validated-fillits/wax42/fillit      has bugs
               # ./validated-fillits/SpenderJ/fillit  has bugs

INDEX=0
SIZE=1
while [ 1 ]
do
	next_index $INDEX $NUM_VALID_FILLITS
	INDEX=$?
	random_size
	SIZE=$?
	./random_tetriminos.py $SIZE
	compare $OUR_FILLIT ${VALID_FILLITS[$INDEX]}
done
