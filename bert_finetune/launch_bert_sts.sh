#!/bin/sh

Learning_Rate="0.00002 0.00003 0.00005"
Batch_Size="32 64"
#Learning_Rate="0.00005 0.00003"
#Batch_Size="64"
Task_Name="STS"
Data_Dir_Name="STS-B"

RESULT_DIR="result_dir-$Task_Name"
if [ ! -d "$RESULT_DIR" ];then
    mkdir $RESULT_DIR 2>/dev/zero
fi

program_home="`echo ~`"
program="$program_home/BERT_STS-B/run_scorer_test.py \
  --task_name=$Task_Name \
  --do_train=true \
  --do_eval=true \
  --data_dir=$GLUE_DIR/$Data_Dir_Name \
  --vocab_file=$BERT_BASE_DIR/vocab.txt \
  --bert_config_file=$BERT_BASE_DIR/bert_config.json \
  --init_checkpoint=$BERT_BASE_DIR/bert_model.ckpt \
  --max_seq_length=128 \
  --num_train_epochs=24.0 \
  --save_checkpoints_steps=10000 "

for lr in $Learning_Rate; do
    echo "learning_rate=$lr"
    for bs in $Batch_Size; do
        echo "batch_size=$bs"
        res_dir="$RESULT_DIR""/lr_$lr""_bs_$bs"
        result="$res_dir""/log.txt"
        FINISH_FILE="$res_dir""/__finished__"

        if [ ! -d "$res_dir" ];then
        	mkdir $res_dir 2>/dev/zero
        	echo "" > $result
        fi

        APP_CMD="python $program --train_batch_size=$bs --learning_rate=$lr --output_dir=$res_dir"
        echo "$APP_CMD" | tee -a $result
        stdbuf -oL $APP_CMD 2>&1 | tee -a $result
        #stdbuf -oL $APP_CMD 2>&1 | tee -a $result &
        #sleep 1h
    done
done
