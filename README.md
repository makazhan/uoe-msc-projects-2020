# Data and Baselines for SIGMORPHON-2019 Shared Task

## Data

**UM vs UD**

The shared task data is based on the [Universal Dependencies](https://universaldependencies.org/) (UD) treebanks and follows the same [CoNLL-U format](https://universaldependencies.org/format.html), but due to specifics of the task only words and their morphological analyses are preserved, i.e. lemmata, POS-tags, and morphological features.
Moreover, the shared task orgonizers have converted UD style morphological annotation into [UniMorph](http://unimorph.org/) (UM) scheme.

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
Crucially, not all UD features was mapped to UM and therefore are absent from the shared task data, e.g. PronType=Prs from the example above has no UM equivalent.
Thus, one cannot simply replace the shared task treebanks with the original UD equivalents.
In order to use the shared task data in the original UD format, one must comvert UM back to UD, which is not trivial.

**Why is it important?**

Baselines such as [UDPipe v1.2](https://github.com/ufal/udpipe), [v2](https://github.com/CoNLL-UD-2018/UDPipe-Future) and [Lemming](https://github.com/lwolfsonkin/lemmingatize) are designed to work with ConLL-U (UD) and related formats.
Although, I have not tried running those tools directly on the UM data, I suspect there might be issues with that format.
Instead I have converted UM back to UD. If you decide to use UDPipe and/or Lemming, you can 

**Data format for Lematus**

hey!


<hr>

