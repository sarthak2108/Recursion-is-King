:-[bounds].

num(5).
cap(3).
refill(2).
fun(1,4).
fun(2,1).
fun(3,-2).
fun(4,3).
fun(5,4).

games:-
	cap(Cap),
	findall(Fun,fun(1,Cap,Fun),List),
	find_max(Max,List),
	output(Max).

fun(N,_,Fun):-
	num(Last),
	N > Last,
	Fun is 0.

fun(N,Amount,Fun):-
	num(Last),
	N =< Last,
	fun(N,F),
	(F > 0
    ->
			[I] in 1..Amount,
			label([I]),
			Fun1 is I*F,
			A4 is Amount-I,
			refill(A4,A2)
    ;
			Fun1 is F,
			A3 is Amount-1,
			refill(A3,A2)
	),
	N1 is N+1,
	fun(N1,A2,Fun2),
	Fun is Fun1+Fun2.
	
refill(A,A2):-
	refill(R),
	A3 is A+R,
	cap(C),
	(A3 < C
    ->
      A2 is A3
    ;
      A2 is C
	).

find_max(Max,List):-
	sort(List,L),
	last(L,Max).

last([M],M):-
	!.
last([_|T],M):-
	last(T,M).
	
output(Max):-
	write(total_fun(Max)), 
	writeln('.').
  
  
