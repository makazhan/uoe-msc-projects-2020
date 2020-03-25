export CUDA_VISIBLE_DEVICES=3
onmt_train -data data-pp/en_gum-um -save_model demo-model -train_steps 5000 -report_every 100 -world_size 1 -gpu_ranks 0 &> train-gpu.log &
