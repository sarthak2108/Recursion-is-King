:-import append/3, length/2, select/3 from basics.

n_pizzas(10).
pizza(1,70).
pizza(2,10).
pizza(3,60).
pizza(4,60).
pizza(5,30).
pizza(6,100).
pizza(7,60).
pizza(8,40).
pizza(9,60).
pizza(10,20).
n_vouchers(4).
voucher(1,1,1).
voucher(2,2,1).
voucher(3,1,1).
voucher(4,1,0).

pizza:-
	findall(C,pizza(_,C),P),
	findall((B,F),voucher(_,B,F),V),
	findall(Cost,buy_all_pizza(P,V,Cost),L),
	min_cost(L,Min),
	write(cost(Min)),
	writeln('.').

buy_all_pizza([],_,0).
buy_all_pizza([H|T],[],Cost):-
	pay([H|T],Cost).
buy_all_pizza([H1|T1],[H2|T2],Cost):-
	select((B,F),[H2|T2],V1),
	buy_pizza(B,[H1|T1],P,P1),
	pay(P,Cost1),
	length(P,L),
	(L < B
	->
		P5 = P1
	;
		min_cost(P,Min),
		find_cheap_pizza(P1,P2,P3,Min),
		get_free_pizza(F,P2,_,P4),
		append(P3,P4,P5)),
	buy_all_pizza(P5,V1,Cost2),
	Cost is Cost1 + Cost2.
	
buy_pizza(0,P,[],P).
buy_pizza(_,[],[],[]).
buy_pizza(N,P,[H|T],P2) :- 
	N > 0,
	select(H,P,P1),
	N1 is N-1,
	buy_pizza(N1,P1,T,P2).

pay([],0).
pay([H|T],C):-
	pay(T,C1),
	C is H + C1.

min_cost(P,M):-
	sort(P,P1),
	P1=[M|_].

find_cheap_pizza([],[],[],_).
find_cheap_pizza([H|T],[H|X],Y,Min):-
	H =< Min,
	find_cheap_pizza(T,X,Y,Min).
find_cheap_pizza([H|T],X,[H|Y],Min):-
	H > Min,
	find_cheap_pizza(T,X,Y,Min).

get_free_pizza(0,P,[],P).
get_free_pizza(_,[],[],[]).
get_free_pizza(F,P,[H|T],P2):-
	F > 0,
	select(H,P,P1),
	F1 is F-1,
	get_free_pizza(F1,P1,T,P2).