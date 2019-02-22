#!/bin/sh


time_execution() {
	/usr/bin/time -p $1 ttmnfile &> time.out
	EX_TIME=`cat time.out | grep "real" | sed "s/real *//g"`
	echo $EX_TIME
}

time_execution_with_timeout() {
	( time_execution $1 ) & pid=$!
	( sleep $TIMEOUT_SECONDS && kill -HUP $pid ) 2>/dev/null & watcher=$!
	if wait $pid 2>/dev/null; then
    	pkill -HUP -P $watcher
    	wait $watcher
	else
   		echo "TIMEOUT"
	fi
}

run_test() {
	./random_tetriminos.py $1
	OURS=$(time_execution_with_timeout $OUR_FILLIT)
	C1=$(time_execution_with_timeout ${VALID_FILLITS[0]})
	C2=$(time_execution_with_timeout ${VALID_FILLITS[1]})
	C3=$(time_execution_with_timeout ${VALID_FILLITS[2]})
	C4=$(time_execution_with_timeout ${VALID_FILLITS[3]})
	echo "$OURS		$C1		$C2		$C3		$C4"
}

print_tets_header() {
	echo "$1 Tetriminos -- timeout is $TIMEOUT_SECONDS seconds."
}

print_names_header() {
	echo "Our fillit	davhojt		jgengo		oanamateiflorin	rchiorea"
}

TIMEOUT_SECONDS=120
OUR_FILLIT=./our-fillit/fillit
VALID_FILLITS=(./validated-fillits/davhojt/fillit
			   ./validated-fillits/jgengo/fillit
			   ./validated-fillits/oanamateiflorin/fillit
			   ./validated-fillits/rchiorea/fillit)

			   # ./validated-fillits/Itokoyamato/fillit   we can't compete with them
			   # ./validated-fillits/ValeriiaMur/fillit   we can't compete with them
			   # ./validated-fillits/wax42/fillit         has bugs
               # ./validated-fillits/SpenderJ/fillit      has bugs

NUM_TETS=1;
echo "Fillit Bench Tester."
echo "Timeout set to $TIMEOUT_SECONDS seconds."
print_names_header
while [ 1 ]
do
	print_tets_header $NUM_TETS
	for value in {1..7}
	do
		run_test $NUM_TETS
	done
	NUM_TETS=$(($NUM_TETS + 1))
done
