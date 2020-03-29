rm -rf models-logs-cpu
mkdir models-logs-cpu
python src/ud_parser.py ../../data-sample/UD_English-GUM/en_gum --epochs "10:1e-3,5:1e-4" --logdir models-logs-cpu --parse 0 --tags "UPOS,FEATS,LEMMAS" &> models-logs-cpu/trn.err &

