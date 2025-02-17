#!/bin/bash
set -x

export CUDA_DEVICE_ORDER="PCI_BUS_ID"

port=$(shuf -i25000-30000 -n1)
method="cluster_activate"
model="t5_large"

cluster=$1
ini_threshold=$2
cluster_constructure_method=$3
activation_combined=$4

deepspeed --master_port $port src/run_uie_lora.py \
   --do_train \
   --do_predict \
   --predict_with_generate \
   --model_name_or_path initial_model/${model} \
   --data_dir CL_Benchmark \
   --task_config_dir configs/order3_configs/yahoo \
   --instruction_file configs/instruction_config.json \
   --instruction_strategy single \
   --output_dir output/${model}/${method}/${cluster_constructure_method}/order_3/outputs/1-yahoo \
   --per_device_train_batch_size 8 \
   --per_device_eval_batch_size 64 \
   --gradient_accumulation_steps 1 \
   --learning_rate 1e-03 \
   --num_train_epochs 1 \
   --deepspeed configs/ds_configs/stage0.config \
   --run_name order3_round1 \
   --max_source_length 512 \
   --max_target_length 50 \
   --generation_max_length 50 \
   --add_task_name True \
   --add_dataset_name True \
   --overwrite_output_dir \
   --overwrite_cache \
   --lr_scheduler_type constant \
   --warmup_steps 0 \
   --logging_strategy steps \
   --logging_steps 10 \
   --evaluation_strategy no \
   --save_strategy no \
   --save_steps 1500 \
   --lamda 0 \
   --method ${method} \
   --is_first_task True

sleep 5

deepspeed --master_port $port src/run_uie_lora.py \
   --do_train \
   --do_predict \
   --predict_with_generate \
   --model_name_or_path output/${model}/${method}/${cluster_constructure_method}/order_3/outputs/1-yahoo/tuning_weight \
   --data_dir CL_Benchmark \
   --task_config_dir configs/order3_configs/amazon \
   --instruction_file configs/instruction_config.json \
   --instruction_strategy single \
   --output_dir output/${model}/${method}/${cluster_constructure_method}/order_3/outputs/2-amazon \
   --per_device_train_batch_size 8 \
   --per_device_eval_batch_size 64 \
   --gradient_accumulation_steps 1 \
   --learning_rate 1e-04 \
   --num_train_epochs 1 \
   --deepspeed configs/ds_configs/stage0.config \
   --run_name order3_round2 \
   --max_source_length 512 \
   --max_target_length 50 \
   --generation_max_length 50 \
   --add_task_name True \
   --add_dataset_name True \
   --overwrite_output_dir \
   --overwrite_cache \
   --lr_scheduler_type constant \
   --warmup_steps 0 \
   --logging_strategy steps \
   --logging_steps 10 \
   --evaluation_strategy no \
   --save_strategy no \
   --save_steps 1500 \
   --lamda 0 \
   --method ${method} \
   --is_first_task False \
   --n_clusters $cluster \
   --cluster_constructure_method ${cluster_constructure_method} \
   --ini_threshold ${ini_threshold} \
   --activation_combined ${activation_combined}

sleep 5

deepspeed --master_port $port src/run_uie_lora.py \
   --do_train \
   --do_predict \
   --predict_with_generate \
   --model_name_or_path output/${model}/${method}/${cluster_constructure_method}/order_3/outputs/2-amazon/tuning_weight \
   --data_dir CL_Benchmark \
   --task_config_dir configs/order3_configs/agnews \
   --instruction_file configs/instruction_config.json \
   --instruction_strategy single \
   --output_dir output/${model}/${method}/${cluster_constructure_method}/order_3/outputs/3-agnews \
   --per_device_train_batch_size 8 \
   --per_device_eval_batch_size 64 \
   --gradient_accumulation_steps 1 \
   --learning_rate 1e-04 \
   --num_train_epochs 1 \
   --deepspeed configs/ds_configs/stage0.config \
   --run_name order3_round3 \
   --max_source_length 512 \
   --max_target_length 50 \
   --generation_max_length 50 \
   --add_task_name True \
   --add_dataset_name True \
   --overwrite_output_dir \
   --overwrite_cache \
   --lr_scheduler_type constant \
   --warmup_steps 0 \
   --logging_strategy steps \
   --logging_steps 10 \
   --evaluation_strategy no \
   --save_strategy no \
   --save_steps 1500 \
   --lamda 0 \
   --method ${method} \
   --is_first_task False \
   --n_clusters $cluster \
   --cluster_constructure_method ${cluster_constructure_method} \
   --ini_threshold ${ini_threshold} \
   --activation_combined ${activation_combined}

sleep 5

deepspeed --master_port $port src/run_uie_lora.py \
   --do_train \
   --do_predict \
   --predict_with_generate \
   --model_name_or_path output/${model}/${method}/${cluster_constructure_method}/order_3/outputs/3-agnews/tuning_weight \
   --data_dir CL_Benchmark \
   --task_config_dir configs/order3_configs/dbpedia \
   --instruction_file configs/instruction_config.json \
   --instruction_strategy single \
   --output_dir output/${model}/${method}/${cluster_constructure_method}/order_3/outputs/4-dbpedia \
   --per_device_train_batch_size 8 \
   --per_device_eval_batch_size 64 \
   --gradient_accumulation_steps 1 \
   --learning_rate 1e-04 \
   --num_train_epochs 1 \
   --deepspeed configs/ds_configs/stage0.config \
   --run_name order3_round4 \
   --max_source_length 512 \
   --max_target_length 50 \
   --generation_max_length 50 \
   --add_task_name True \
   --add_dataset_name True \
   --overwrite_output_dir \
   --overwrite_cache \
   --lr_scheduler_type constant \
   --warmup_steps 0 \
   --logging_strategy steps \
   --logging_steps 10 \
   --evaluation_strategy no \
   --save_strategy no \
   --save_steps 1500 \
   --lamda 0 \
   --method ${method} \
   --is_first_task False \
   --n_clusters $cluster \
   --cluster_constructure_method ${cluster_constructure_method} \
   --ini_threshold ${ini_threshold} \
   --activation_combined ${activation_combined}