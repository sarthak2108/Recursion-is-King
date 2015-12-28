:-import append/3, member/2, length/2 from basics.
:-[bounds].

board_size(4).
pos(1,2). 
pos(2,4).
pos(3,1). 
pos(4,3).

fqueens:-
	findall((X,Y),pos(X,Y),I),
	find_pos(I,[],P),
	findall(Moves,place(P,I,[],Moves),M),
	min_cost(M,C),
	write(moves(C)),
	writeln('.').

find_pos([],P,P).
find_pos([H|T],L,P):-
	findall(Pos,move_queen(H,Pos),L1),
	append(L,[L1],L2),
	find_pos(T,L2,P).

place([],I,Q,M):-
	board_size(N),
	sort(Q,Q1),
	length(Q1,N),
	safe(Q1),
	delete_all(I,Q1,P),
	length(P,M).
place([H|T],I,Q,M):-
	member(P,H),
	append(Q,[P],Q1),
	place(T,I,Q1,M).

safe([]).
safe([Q|Qs]):-
	safe(Qs,Q),
	safe(Qs).
safe([],_).
safe([(X,Y)|Qs],(X0,Y0)):-
	X0 \= X,
	Y0 \= Y,
	X1 is abs(X0 - X),
	Y1 is abs(Y0 - Y),
	X1 \= Y1,
	safe(Qs,(X0,Y0)).

move_queen((X1,Y1),(X2,Y2)):-
	board_size(N),
	[X2,Y2] in 1..N,
	N1 is N - 1,
	[M] in -N1..N1,
	X2 #= X1 + M,
	Y2 #= Y1,
	label([X2,Y2]).
move_queen((X1,Y1),(X2,Y2)):-
	board_size(N),
	[X2,Y2] in 1..N,
	N1 is N - 1,
	[M] in -N1..N1,
	X2 #= X1,
	Y2 #= Y1 + M,
	label([X2,Y2]).
move_queen((X1,Y1),(X2,Y2)):-
	board_size(N),
	[X1,Y1,X2,Y2] in 1..N,
	N1 is N - 1,
	[M] in -N1..N1,
	X2 #= X1 + M,
	Y2 #= Y1 + M,
	label([X2,Y2]).
move_queen((X1,Y1),(X2,Y2)):-
	board_size(N),
	[X1,Y1,X2,Y2] in 1..N,
	N1 is N - 1,
	[M1,M2] in 1..N1,
	M1 + M2 #= 0,
	X2 #= X1 + M1,
	Y2 #= Y1 + M2,
	label([X2,Y2]).

min_cost(L,M):-
	sort(L,[M|_]).

delete_all([],L,L).
delete_all([H|T],L,L1):-
	(member(H,L)
	->
		delete(L,H,L2),
		delete_all(T,L2,L1)
	;
		delete_all(T,L,L1)).

delete([X|T],X,T).
delete([H|T],X,[H|T1]):-
	delete(T,X,T1).
	