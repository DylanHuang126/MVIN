#!/bin/bash

export CUDA_VISIBLE_DEVICES=$1
# export PYTHONPATH="../../usr/local/lib/python3.6/dist-packages"
# export PYTHONPATH="../../usr/lib/python3/dist-packages"
export PYTHONPATH="."

dataset="amazon-book_20core"
aggregator="sum"
n_epochs=20
neighbor_sample_size=8
n_memory=16
dim=16
batch_size=512
l2_weight=1e-7
l2_agg_weight=1e-7
lr=5.5e-3
ablation='all'

h_hop=2
p_hop=1
n_mix_hop=1

tolerance=6
early_decrease_lr=2
early_stop=2

file_name="main.py"
log_name=${dataset}

DIM_SIZE=(16)

for DIM_SIZE in ${DIM_SIZE[@]}
do
	dim=$DIM_SIZE
	log_nameaaa=${log_name}_p0${p_hop}_h${h_hop}_n_mix${n_mix_hop}_ba_${batch_size}_nb_${neighbor_sample_size}_l2_${l2_weight}_ag_${l2_agg_weight}_dim_${dim}
	save_model_name=${log_nameaaa}
	n_memory=16
	cmd_min="python ../model/MVIN/${file_name} --log_name $log_nameaaa --save_model_name $save_model_name --dataset $dataset
		  --aggregator $aggregator --n_epochs $n_epochs --neighbor_sample_size $neighbor_sample_size --p_hop $p_hop --n_memory $n_memory
		  --dim $dim --n_mix_hop $n_mix_hop --h_hop $h_hop --batch_size $batch_size --l2_weight $l2_weight --l2_agg_weight $l2_agg_weight 
		  --ablation $ablation --lr $lr --early_decrease_lr $early_decrease_lr --early_stop $early_stop"
	echo ${cmd_min}
	$cmd_min
done
