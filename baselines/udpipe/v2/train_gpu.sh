export LD_LIBRARY_PATH=/opt/cuda-10.0.130/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/opt/cuda-10.0.130:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/opt/cuDNN-7.6.0.64_9.2/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/opt/cuDNN-7.6.0.64_9.2/include:$LD_LIBRARY_PATH
export CUDA_VISIBLE_DEVICES=$1

rm -rf models-logs
mkdir models-logs
python src/ud_parser.py ../../data-sample/UD_English-GUM/en_gum --epochs "10:1e-3,5:1e-4" --logdir models-logs --parse 0 --tags "UPOS,FEATS,LEMMAS" &> models-logs/trn.err &

