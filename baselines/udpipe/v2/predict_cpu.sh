rm -rf predictions-logs-cpu 
mkdir predictions-logs-cpu 
python src/ud_parser.py ../../data-sample/UD_English-GUM/en_gum  --predict --predict_input ../../data-sample/UD_English-GUM/en_gum-ud-dev.conllu --predict_output out-cpu.conllu --checkpoint models-logs/checkpoint-inference-last --logdir predictions-logs-cpu --parse 0 --tags "UPOS,FEATS,LEMMAS" &> predictions-logs-cpu/prd.err &
