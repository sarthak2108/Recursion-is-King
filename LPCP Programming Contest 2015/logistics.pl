:-import append/3, member/2 from basics.

graph_size(6).
start(1).
dest(5).
dest(6).
edge(1,2,4).
edge(1,3,2).
edge(2,3,5).
edge(2,4,10).
edge(3,5,3).
edge(4,5,4).
edge(4,6,11).

logistics:-
	start(S),
	findall(D1,dest(D1),D),
	findall(C1,find_route(S,D,[],C1),C),
	min_cost(C,M),
	write(min_cost(M)),
	writeln('.').

find_route(_,[],L,C):-
	purge(L,[],L1),
	compute_cost(L1,C).
find_route(S,[H|T],L,C):-
	route(S,H,[],R),
	append(L,R,L1),
	find_route(S,T,L1,C).

route(A,B,L,R):-
	edge(A,B,Cost),
	append(L,[edge(A,B,Cost)],R).
route(A,B,L,R):-
	edge(B,A,Cost),
	append(L,[edge(B,A,Cost)],R).
route(A,B,L,R):-
	edge(A,C,Cost),
	\+ member(edge(A,C,Cost),L),
	append(L,[edge(A,C,Cost)],L1),
	route(C,B,L1,R).
route(A,B,L,R):-
	edge(C,A,Cost),
	\+ member(edge(C,A,Cost),L),
	append(L,[edge(C,A,Cost)],L1),
	route(C,B,L1,R).

purge([], L, L).		
purge([H|T], T1, L):-
	\+ member(H, T1),
	append(T1, [H], T2),
	purge(T, T2, L).
purge([H|T], T1, L):-
	member(H, T1),
	purge(T, T1, L).
	
compute_cost([],0).
compute_cost([edge(_,_,C)|T],Cost):-
	compute_cost(T,C1),
	Cost is C + C1.

min_cost(L,M):-
	sort(L,[M|_]).
	