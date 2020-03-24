# Data and Baselines for SIGMORPHON-2019 Shared Task

## Data

The shared task data is based on the [Universal Dependencies](https://universaldependencies.org/) (UD) treebanks and follows the same [CoNLL-U format](https://universaldependencies.org/format.html), but due to specifics of the task only words and their morphological analyses are preserved, i.e. lemmata, POS-tags, and morphological features.
Moreover, UD style morphological annotation is converted to [UniMorph](http://unimorph.org/) (UM) scheme.

For example, this is a sentence from the shared task data (UM):
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

and this is the UD original it was converted from:
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

The fact that UD version is more generously annotated is not very important to us, as for the task at hand we do not need all those labels.
Let us now compare just first lines of UM and UD annotations, ignoring those non-essential labels:
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
Crucially, not all UD features can be mapped to UM and therefore are absent from the shared task data.

**Why all this is important?**

Baselines such as UDPipe v1.2, v2 and Lemming are designed to work with ConLL-U (UD) and related formats.
One must be able to run them directly on the shared task (UM) data, but it is advisible to convert the data back to UD first.
At least for Lemming, I have tried both options and concluded that conversion back to UD yields better results.

<hr>

