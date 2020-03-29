export LD_LIBRARY_PATH=/opt/cuda-10.0.130/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/opt/cuda-10.0.130:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/opt/cuDNN-7.6.0.64_9.2/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/opt/cuDNN-7.6.0.64_9.2/include:$LD_LIBRARY_PATH
export CUDA_VISIBLE_DEVICES=$1

rm -rf predictions-logs 
mkdir predictions-logs 
python src/ud_parser.py ../../data-sample/UD_English-GUM/en_gum  --predict --predict_input ../../data-sample/UD_English-GUM/en_gum-ud-dev.conllu --predict_output out.conllu --checkpoint models-logs/checkpoint-inference-last --logdir predictions-logs --parse 0 --tags "UPOS,FEATS,LEMMAS" &> predictions-logs/prd.err &
