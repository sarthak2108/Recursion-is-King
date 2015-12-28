%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% myeval/5, like maxval/3 accepts a
% structure of the form tree(X,Y).
% But unlike maxval/3, it accpets the
% permutations of the list of operators
% and not just the list of operators.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

maxval(tree(X,Y),[H|T],M):-
	findall(L,permute([H|T],L),[Hs|Ts]),
	myeval(tree(X,Y),Hs,M,0,Ts),
	!.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% eval/4 evaluates the tree for a particular
% permutation of the operators. When a
% leaf node is reached, eval/4 returns the
% value at the leaf. The maximum of all
% the values computed by eval/4 is set as
% M by myeval/5. Three operators are possible,
% 'min', 'plus', 'mult'.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

myeval(tree(X,Y),L,M,M1,[]):-
	eval(tree(X,Y),L,_,V),
	V >= M1,
	M is V.
myeval(tree(X,Y),L,M,M1,[]):-
	eval(tree(X,Y),L,_,V),
	V < M1,
	M is M1.
myeval(tree(X,Y),L,M,M1,[Hs|Ts]):-
	eval(tree(X,Y),L,_,V),
	V >= M1,
	myeval(tree(X,Y),Hs,M,V,Ts).
myeval(tree(X,Y),L,M,M1,[Hs|Ts]):-
	eval(tree(X,Y),L,_,V),
	V < M1,
	myeval(tree(X,Y),Hs,M,M1,Ts).

eval(X,O,L,V):-
	number(X),
	V is X,
	L=O.
eval(tree(X,Y),[H|T],L,V):-
	H=min,
	eval(X,T,L1,V1),
	eval(Y,L1,L2,V2),
	V is V1-V2,
	L=L2.
eval(tree(X,Y),[H|T],L,V):-
	H=plus,
	eval(X,T,L1,V1),
	eval(Y,L1,L2,V2),
	V is V1+V2,
	L=L2.
eval(tree(X,Y),[H|T],L,V):-
	H=mult,
	eval(X,T,L1,V1),
	eval(Y,L1,L2,V2),
	V is V1*V2,
	L=L2.
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Utility predicates.
%
% delete/3 deletes the specified element
% from the given list.
%
% permute/2 utilizes delete/3 and makes
% use of Prolog's inherent backtracking
% to generate all possible permutations
% of a list.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

delete([X|Ys],X,Ys).
delete([Y|Ys],X,[Y|Zs]):-
	delete(Ys,X,Zs).

permute([],[]).
permute([X|Xs],Ys):-
	permute(Xs,Zs),
	delete(Ys,X,Zs).
