#!/bin/sh

#
# Disable THP migration
# Set maximum memory size to 2048MB
# Set fast memory size to 128MB
#

CPUS_NUM="`cat /proc/cpuinfo|grep processor|wc -l`"

thp_migration=0

MEM_SIZE="`cat /proc/meminfo |grep MemTotal|cut -d: -f2|cut -dk -f1`"
#MEM_SIZE="`expr $MEM_SIZE / 1024`"


#echo "Detected memory size: $MEM_SIZE MB"
echo "Detected cpus       : $CPUS_NUM"




#30 minutes
#kill_timeout="`expr 30 * 60`"


PER_NODE_THREADS="`expr $CPUS_NUM / 2`"
#PER_NODE_MEM_SIZE="`expr $MEM_SIZE / 2`"


echo "PER_NODE_THREADS=$PER_NODE_THREADS"
#echo "PER_NODE_MEM_SIZE=$PER_NODE_MEM_SIZE"

#1G 2G 3G
FASTMEM_SIZE_LIST="`seq 3072 3072 12288`"


echo "FASTMEM_SIZE_LIST=`echo $FASTMEM_SIZE_LIST`"

program_home="`echo ~`"
BERT_BASE_DIR="/home/cc/bert/wwm_uncased_L-24_H-1024_A-16"
GLUE_DIR="/home/cc/bert/glue_data/"
#program="$program_home/models/official/wide_deep/census_main.py --train_epochs=5"
#program="$program_home/DCGAN-tensorflow/main.py --dataset mnist --input_height=28 --output_height=28 --train --epoch=1"
program="$program_home/bert/run_classifier.py \
  --task_name=sst \
  --do_train=true \
  --do_eval=true \
  --data_dir=$GLUE_DIR/SST-2 \
  --vocab_file=$BERT_BASE_DIR/vocab.txt \
  --bert_config_file=$BERT_BASE_DIR/bert_config.json \
  --init_checkpoint=$BERT_BASE_DIR/bert_model.ckpt \
  --max_seq_length=128 \
  --train_batch_size=32 \
  --learning_rate=2e-5 \
  --num_train_epochs=3.0 \ "
#  --output_dir=/home/cc/bert/sst_output/ "
#  --output_dir=$program_home/bert/mrpc_output_$memsize/"

#num_residual_blocks : int. The total layers of the ResNet = 6 * num residual blocks + 2

for memsize in $FASTMEM_SIZE_LIST; do

	echo "fastmemsize=$memsize MB thp=0"

	#--kill-timeout=$kill_timeout
	./launch_testee.sh      --thp-migration=0 \
            	            --fast-mem-size=$memsize \
                	        --migration-threads-num=$PER_NODE_THREADS \
                    	    python $program "--output_dir=$program_home/bert/sst_output_$memsize/" "--version=test_fastmem_$memsize""_MB_thp_0"

#	echo "fastmemsize=$memsize MB thp=1"
#
#	./launch_testee.sh      --thp-migration=1 \
 #           	            --fast-mem-size=$memsize \
 #               	        --migration-threads-num=$PER_NODE_THREADS \
#                    	    python $program "--version=test_fastmem_$memsize""_MB_thp_1"
done



