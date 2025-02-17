# !/bin/bash

clusters=(32)
ini_thresholds=(0.66 0.75 0.80 0.85 0.5 0.4 0.3)
cluster_constructure_methods=("sequential")
activation_combined=True
method="cluster_activate"
model="t5_large"
for cluster_constructure_method in "${cluster_constructure_methods[@]}"; do
  for ini_threshold in "${ini_thresholds[@]}"; do
    for cluster in "${clusters[@]}"; do
        lor_dir=output/${model}/${method}/${cluster_constructure_method}/order_3/logs
        log_path=${lor_dir}/train_and_infer_${cluster}_${ini_threshold}_${activation_combined}.log
        mkdir -p ${lor_dir}

        # 检查log文件是否存在
        if [ ! -f "${log_path}" ]; then
            # log文件不存在，执行脚本
            echo "bash scripts/${model}/${method}/order_3.sh ${cluster} ${ini_threshold} ${cluster_constructure_method} ${activation_combined} > ${log_path} 2>&1"
            bash scripts/${model}/${method}/order_3.sh ${cluster} ${ini_threshold} ${cluster_constructure_method} ${activation_combined} > ${log_path} 2>&1
        else
            echo "Log file ${log_path} already exists, skipping..."
        fi
    done
  done
done
