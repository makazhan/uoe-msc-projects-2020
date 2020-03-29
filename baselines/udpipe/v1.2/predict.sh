#!/bin/bash
bin/bin-linux64/udpipe --tag en_gum.mdl ../../data-sample/UD_English-GUM/en_gum-ud-dev.conllu > out.conllu 2> /dev/null &
