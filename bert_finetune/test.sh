#!/bin/sh

i=0
j=0
k=0

maxi=2
maxj=3
maxk=4

i_list="`seq 1 $maxi`"
j_list="`seq 1 $maxj`"
k_list="`seq 1 $maxk`"

program_home="`echo ~`"

program="$program_home/resnet-in-tensorflow/cifar10_train.py --num_residual_blocks=5 --report_freq=60 --train_steps=1500"
cmd="python $program"

for i in $i_list;do
	#echo "i=$i"
	stdbuf -oL $cmd
	
	
	'''for j in $j_list; do
		
		echo "  j=$j"
		
		for k in $k_list; do
			echo "    k=$k"
		done

	done'''
done

