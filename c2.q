//words
ws:read0`:c2dict.txt
cip:lower first read0`:c2input.txt
//cip:lower" DV  NWECEE E ODEOAIEFACRSRLTE"

//pad, cut, flip 
chop:{flip x cut y,mod[x-count[y]mod x;x]#" "}

//is (likely) a text?
text:{0.7<avg any(" "vs x where (x:ssr/[x;"(),.-";" "]) in " ",.Q.a)~\:/:ws}

//find matching word segments
fnd:{[c;s]
	w:ws where count[s]<=count'[ws];
	w:w where all flip s in/:w;
	w:raze{x#'(count[y]-x)(1_)\y}[count s]'[w];
	m:asc[s]~/:asc'[w];
	$[c;any m;w where m]
 }

//word segment candidates
cand:{[n]c where not any flip " .,()-"in/:c:chop[n]cip}

//% of word segments found
f:{[n]c:cand n;$[count c;avg fnd[1]':[c];0f]}

//cuts to have 5-16 cols
n:ceiling count[cip] % 5+til 12

//fishing
m:f'[n]

iws:iasc':[ws]

//results
{[n]
	//unique lettered likely word segments
	l:{x where x~'distinct'[x]}cand n;
	//not lucky
	if[0=count l;:()]; 
	//possible permutations
	p:distinct raze {x?/:distinct fnd[0]x}':[l];
	//any of these produce a text?
	{if[text raze x@\:y;show ws where iasc[y]~/:iws]}[chop[n;cip]]':[p]
 } each n where 0.7<m;

decip:{raze chop[ceiling count[cip]%count x;cip]@\:iasc iasc x}
-1"Try function decip with any of the above code-words, and you will get:";

decip"parallax"