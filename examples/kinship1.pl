:- use_module('../metagol').

%% background knowledge
mother(ann,amy).
mother(ann,andy).
mother(amy,amelia).
mother(linda,gavin).
father(steve,amy).
father(steve,andy).
father(gavin,amelia).
father(andy,spongebob).

%% tell metagol to use the BK
prim(mother/2).
prim(father/2).

%% metarules
metarule([P,Q],([P,A,B]:-[[Q,A,B]])).
metarule([P,Q,R],([P,A,B]:-[[Q,A,C],[R,C,B]])).

%% learn grandparent by inventing parent
a :-
  Pos = [
    grandparent(ann,amelia),
    grandparent(steve,amelia),
    grandparent(ann,spongebob),
    grandparent(steve,spongebob),
    grandparent(linda,amelia)
  ],
  Neg = [
    grandparent(amy,amelia)
  ],
  learn(Pos,Neg,Prog),
  pprint(Prog).

%% example of a failure
b :-
  Pos = [
    grandparent(ann,amelia)
  ],
  Neg = [
    grandparent(ann,amelia)
  ],
  (learn(Pos,Neg,_Prog) -> false; writeln('failed to learn a theory')).
