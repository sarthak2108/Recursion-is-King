%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% convert/2 takes the list of structures, X
% and converts it to a list of lists, X1.
%
% count/4 determines the number of friends, C.
% This code can handle any number of friends.
%
% L1 holds all possible combinations of C
% routes taken from X1.
%
% purge/2 eliminates all those combinitions
% from L1 which contains multiple routes of
% the same friend, and creates L2.
%
% maxpl computes the maximum possible
% pleasure achievable from the combinations
% in L2.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
maximalpleasure(X,T,M,P):-
	convert(X,X1),
	count(X1,[],0,C),
	findall(L,combination(C,X1,L),L1),
	purge(L1,L2),
	maxpl(L2,T,M,0,P),
	!.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pleasure/5 computes the pleasure achieved
% from a particular combination of routes.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
maxpl([],_,_,P1,P):-
	P is P1.
maxpl([H1|T1],T,M,P1,P):-
	findall(L,combination(2,H1,L),L1),
	pleasure(L1,T,M,0,P2),
	P2 >= P1,
	maxpl(T1,T,M,P2,P).
maxpl([H1|T1],T,M,P1,P):-
	findall(L,combination(2,H1,L),L1),
	pleasure(L1,T,M,0,P2),
	P2 < P1,
	maxpl(T1,T,M,P1,P).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pl/8 considers any two friens out of
% the C considered and computes their
% pleasure. Value returned by pleasure/5
% is the sum of pleasures of all pairs.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pleasure([],_,_,P1,P):-
	P is P1.
pleasure([H1|T1],T,M,P1,P):-
	[H2|T2]=H1,
	[H3|_]=T2,
	[_|T4]=H2,
	[H5|_]=T4,
	[_|T6]=H3,
	[H7|_]=T6,
	[H8|T8]=H5,
	[H9|T9]=H7,
	pl(H8,H9,T8,T9,T,M,0,P2),
	P3 is P1+P2,
	pleasure(T1,T,M,P3,P).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pl/8 always maintains the previously
% visited city and the current city.
% If, for a pair, both matches, a pleasure
% of 2*T+2*M is recorded as the pair has
% stayed together in the previous city
% and also travelled together. If only
% the previous cities match, a pleasure of 2*M
% is added as they stayed together at
% the previous city but travelled separately.
% If the previous cities don't match,
% no pleasure is recorded.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
pl(X1,X2,[],_,_,M,P1,P):-
	X1=X2,
	P2 is P1 + 2*M,
	P is P2.
pl(X1,X2,_,[],_,_,P1,P):-
	X1\=X2,
	P is P1.
pl(X1,X2,[H1|T1],[H2|T2],T,M,P1,P):-
	X1=X2,
	H1=H2,
	P2 is P1 + 2*(M+T),
	pl(H1,H2,T1,T2,T,M,P2,P).
pl(X1,X2,[H1|T1],[H2|T2],T,M,P1,P):-
	X1=X2,
	H1\=H2,
	P2 is P1 + 2*M,
	pl(H1,H2,T1,T2,T,M,P2,P).
pl(X1,X2,[H1|T1],[H2|T2],T,M,P1,P):-
	X1\=X2,
	pl(H1,H2,T1,T2,T,M,P1,P).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Utility predicates. All have been discussed
% previously, except one, repeat/3, member/2 
% and combination/3.
%
% repeat/3 determines if a combination
% of routes contains multiple routes
% for the same friend. This information
% is utilized by purge/2.
%
% member/2 determines if an element is
% a member of a list.
%
% combination/3 finds a combination of
% K elements from some list of elements.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	
convert([],[]).
convert([H|T],X):-
	H=..[_|T1],
	X=[T1|X1],
	convert(T,X1).

count([],_,C1,C):-
	C is C1.
count([H|T],X1,C1,C):-
	[H1|_]=H,
	member(H1,X1),
	count(T,X1,C1,C).
count([H|T],X1,C1,C):-
	[H1|_]=H,
	X2=[H1|X1],
	C2 is C1+1,
	count(T,X2,C2,C).

purge([],[]). 
purge([H1|T1],L2):-
	repeat(H1,[],R),
	R is 1,
	purge(T1,L2).
purge([H1|T1],L2):-
	repeat(H1,[],R),
	R is 0,
	L2=[H1|L3],
	purge(T1,L3).

repeat([],_,0).
repeat([H|_],L,R):-
	[H1|_]=H,
	member(H1,L),
	R is 1.
repeat([H|T],L,R):-
	L1=[L|H],
	repeat(T,L1,R).

member(A,[A|_]).
member(A,[_|T]):-
	member(A,T).

combination(0,_,[]).
combination(K,L,[X|Xs]) :- 
	K > 0,
	el(X,L,R),
	K1 is K-1,
	combination(K1,R,Xs).

el(X,[X|L],L).
el(X,[_|L],R) :- 
	el(X,L,R).