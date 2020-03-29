# Data and Baselines for SIGMORPHON-2019 Shared Task

### Data

**UM vs UD**

The shared task data is based on the [Universal Dependencies](https://universaldependencies.org/) (UD) treebanks and follows the same [CoNLL-U format](https://universaldependencies.org/format.html), but due to specifics of the task only words and their morphological analyses are preserved, i.e. lemmata, POS-tags, and morphological features.
Moreover, the shared task organizers have converted UD style morphological annotation into [UniMorph](http://unimorph.org/) (UM) scheme.

For example, this is a sentence from the shared task data:
<pre>
# sent_id = 1964
# text = We need you; whatever you like!
1	We	we	_	_	PL;1;NOM;PRO	_	_	_	_
2	need	need	_	_	V;FIN;IND;PRS	_	_	_	_
3	you	you	_	_	PRO	_	_	_	_
4	;	;	_	_	_	_	_	_	_
5	whatever	whatever	_	_	PRO	_	_	_	_
6	you	you	_	_	PRO	_	_	_	_
7	like	like	_	_	V;FIN;IND;PRS	_	_	_	_
8	!	!	_	_	_	_	_	_	_
</pre>

it was converted to UM from this original UD version:
<pre>
# sent_id = 1964
# text = We need you; whatever you like!
1	We	we	PRON	PERS-P1PL-NOM	Case=Nom|Number=Plur|Person=1|PronType=Prs	2	nsubj	_	_
2	need	need	VERB	PRES	Mood=Ind|Tense=Pres|VerbForm=Fin	0	root	_	_
3	you	you	PRON	PERS-P2	_	2	obj	_	SpaceAfter=No
4	;	;	PUNCT	Semicolon	_	2	punct	_	_
5	whatever	whatever	PRON	WH-IND	PronType=Int	7	obj	_	_
6	you	you	PRON	PERS-P2	_	7	nsubj	_	_
7	like	like	VERB	PRES	Mood=Ind|Tense=Pres|VerbForm=Fin	2	advcl	_	SpaceAfter=No
8	!	!	PUNCT	ExclMark	_	7	punct	_	_
</pre>

The fact that the UD version is more generously annotated is not very important, as for the task at hand those extra labels are not needed.
Let us now compare just the first lines of UM and UD annotations, ignoring those non-essential labels:
<pre>
UM: 1	We	we	_	_	PL;1;NOM;PRO	_	_	_	_
UD: 1	We	we	PRON	_	Case=Nom|Number=Plur|Person=1|PronType=Prs	_	_	_	_
</pre>
here is the corresponding UD &#8594; UM mapping:
<pre>
PRON          → PRO;
Case=Nom      → NOM;
Number=Plur   → PL;
Person=1      → 1;
PronType=Prs  → N/A.
</pre>
Crucially, not all UD features were mapped to UM and therefore are absent from the shared task data, e.g. PronType=Prs from the example above has no UM equivalent.
Thus, one cannot simply replace the shared task treebanks with the original UD equivalents.
In order to use the shared task data in the original UD format, one must convert UM back to UD, which is not trivial.

**Data format for UDPipe and Lemming**

Baselines such as [UDPipe v1.2](https://github.com/ufal/udpipe), [v2](https://github.com/CoNLL-UD-2018/UDPipe-Future) and [Lemming](https://github.com/lwolfsonkin/lemmingatize) are designed to work with ConLL-U (UD) and related formats.
Although, I have not tried running those tools directly on the UM data, I suspect there might be issues with it.
Instead I have converted UM data back to UD format.
If you decide to use UDPipe and/or Lemming, you can use restored UD data from this repo, i.e. `data/restored_ud.zip` (there are three parts).

**Data format for OpenNMT-py**

OpenNMT-py expects the input in two separate files: source and target.
This applies to all data splits: train, dev, and test.
For instance, our example sentence pre-processed for Lematus with 3 characters context window might look like this:

<pre>
source file:                                target file:
&lt;lc&gt; W e &lt;rc&gt; n e e                         w e
W e &lt;lc&gt; n e e d &lt;rc&gt; y o u                 n e e d
e e d &lt;lc&gt; y o u &lt;rc&gt; ; &lt;s&gt; w               y o u
y o u &lt;lc&gt; ; &lt;rc&gt; w h a                     ;
u &lt;s&gt; ; &lt;lc&gt; w h a t e v e r &lt;rc&gt; y o u     w h a t e v e r
v e r &lt;lc&gt; y o u &lt;rc&gt; l i k                 y o u
y o u &lt;lc&gt; l i k e &lt;rc&gt; !                   l i k e
i k e &lt;lc&gt; ! &lt;rc&gt;                           !
</pre>

There are several ways to incorporate morpho-tags into this set up, if your goal is morpho-analysis.
An obvious one is just to add the tags to the target side, e.g.:

<pre>
source file:                                target file:
&lt;lc&gt; W e &lt;rc&gt; n e e                         w e +PL +1 +NOM +PRO
W e &lt;lc&gt; n e e d &lt;rc&gt; y o u                 n e e d +V +FIN +IND +PRS
e e d &lt;lc&gt; y o u &lt;rc&gt; ; &lt;s&gt; w               y o u +PRO
y o u &lt;lc&gt; ; &lt;rc&gt; w h a                     ; +_
u &lt;s&gt; ; &lt;lc&gt; w h a t e v e r &lt;rc&gt; y o u     w h a t e v e r +PRO
v e r &lt;lc&gt; y o u &lt;rc&gt; l i k                 y o u +PRO
y o u &lt;lc&gt; l i k e &lt;rc&gt; !                   l i k e +V +FIN +IND +PRS
i k e &lt;lc&gt; ! &lt;rc&gt;                           ! +_
</pre>

It may be worth thinking about (or experimenting with) the type of context that better suits morpho-analysis: parts of words (as in example above), e.g. `v e r <lc> y o u <rc> l i k` or whole words, e.g. `w h a t v e r <lc> y o u <rc> l i k e`.

Also, the order of tags in UM data is not fixed, i.e. tags may appear in different order for the same analysis, e.g. `w e +PL +1 +NOM +PRO`, `w e +PRO +PL +NOM +1`, etc.
This is just for your information.
I have not run any comparative experiments with unordered vs ordered data, so I cannot tell if there is an issue with lack of ordering.

Lastly, mind the whitespace!
There might be spaces inside word forms or lemmata due to annotation errors or specifics of the writing system, e.g. Vietnamese syllables are written space-separated; hence it is common to encounter words and lemmata that contain spaces: 
<pre>
...
8       nhà nghỉ        nhà nghỉ        _       _       N       _       _       _       _
...
</pre>

<hr>

## Baselines

**Lematus (OpenNMT-py based)**

- Paper

[Context Sensitive Neural Lemmatization with Lematus](https://www.aclweb.org/anthology/N18-1126/)

- Installation

To install the latest version follow instructions on the [official repo](https://github.com/OpenNMT/OpenNMT-py).
The latest version requires Pytorch v1.4, which may not work with cuda v10.1 on some DICE servers.
If that is the case try re-installing Pytorch with cuda v9.2 (see the [official website](https://pytorch.org/get-started/locally/) for instructions).

- Testing

To test your installation you can try running the following test scripts located at `baselines/onmtpy/`:

-- `dp.sh` - standard OpenNMT data preprocessing;

-- `train_gpu.sh` / `train_cpu.sh` - training a default OpenNMT seq2seq architecture on gpu/cpu.


**UDPipe**

- Paper

Version 2 (one of the top performing shared task submissions are based on this version): [UDPipe 2.0 Prototype at CoNLL 2018 UD Shared Task](https://www.aclweb.org/anthology/K18-2020/)

Version 1.2: [UDPipe: Trainable Pipeline for Processing CoNLL-U Files Performing Tokenization, Morphological Analysis, POS Tagging and Parsing](https://www.aclweb.org/anthology/L16-1680/)

- Installation

The easiest way to work with version 1.2 is just to download the binaries (executables) for your system from https://github.com/ufal/udpipe/releases/.

Likewise, just clone the [official repo](https://github.com/CoNLL-UD-2018/UDPipe-Future) to work with version 2.
This version requires tensorflow.

- Testing

To test version 1.2 try running `train.sh` and `predict.sh` scripts located at `baselines/udpipe/v1.2`.
`train.sh` produces the train log in a silent mode, which you can monitor on Linux with `tail -f en_gum.log` command.

To test version 2 try running `train_gpu.sh` and `predict_gpu.sh` scripts located at `baselines/udpipe/v2`.
Both scripts require GPU id as an argument; pass 0 if unsure.
Alternatively, you may try testing on CPU via `train_cpu.sh` and `predict_cpu.sh` scripts that expect no arguments.

