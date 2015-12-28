:-import append/3, member/2 from basics.
:-[bounds].

r(0).
s(0).
l(2).
t(2).

packing:-
	r(R),
	create_list(r,R,L1),
	s(S),
	create_list(s,S,L2),
	t(T),
	create_list(t,T,L3),
	l(L),
	create_list(l,L,L4),
	append(L1,L2,L5),
	append(L3,L4,L6),
	append(L5,L6,[T1,T2,T3,T4]),
	findall([(X11,Y11),(X12,Y12),(X13,Y13),(X14,Y14)],pack(T1,[(X11,Y11),(X12,Y12),(X13,Y13),(X14,Y14)]),P1),
	findall([(X21,Y21),(X22,Y22),(X23,Y23),(X24,Y24)],pack(T2,[(X21,Y21),(X22,Y22),(X23,Y23),(X24,Y24)]),P2),
	findall([(X31,Y31),(X32,Y32),(X33,Y33),(X34,Y34)],pack(T3,[(X31,Y31),(X32,Y32),(X33,Y33),(X34,Y34)]),P3),
	findall([(X41,Y41),(X42,Y42),(X43,Y43),(X44,Y44)],pack(T4,[(X41,Y41),(X42,Y42),(X43,Y43),(X44,Y44)]),P4),
	member(A1,P1),
	member(A2,P2),
	member(A3,P3),
	member(A4,P4),
	append(A1,A2,A5),
	append(A3,A4,A6),
	append(A5,A6,A7),
	all_different(A7).

create_list(_,0,[]).
create_list(T,C,[T|L]):-
	C > 0,
	C1 is C - 1,
	create_list(T,C1,L).

pack(r,[(X1,Y1),(X2,Y2),(X3,Y3),(X4,Y4)]):-
	[X1,Y1,X2,Y2,X3,Y3,X4,Y4] in 1..4,
	X2 #= X1,
	Y2 #= Y1 + 1,
	X3 #= X1,
	Y3 #= Y1 + 2,
	X4 #= X1,
	Y4 #= Y1 + 3,
	label([X1,Y1,X2,Y2,X3,Y3,X4,Y4]).
pack(r,[(X1,Y1),(X2,Y2),(X3,Y3),(X4,Y4)]):-
	[X1,Y1,X2,Y2,X3,Y3,X4,Y4] in 1..4,
	X2 #= X1 + 1,
	Y2 #= Y1,
	X3 #= X1 + 2,
	Y3 #= Y1,
	X4 #= X1 + 3,
	Y4 #= Y1,
	label([X1,Y1,X2,Y2,X3,Y3,X4,Y4]).
pack(s,[(X1,Y1),(X2,Y2),(X3,Y3),(X4,Y4)]):-
	[X1,Y1,X2,Y2,X3,Y3,X4,Y4] in 1..4,
	X2 #= X1,
	Y2 #= Y1 + 1,
	X3 #= X1 + 1,
	Y3 #= Y1 + 1,
	X4 #= X1 + 1,
	Y4 #= Y1,
	label([X1,Y1,X2,Y2,X3,Y3,X4,Y4]).
pack(t,[(X1,Y1),(X2,Y2),(X3,Y3),(X4,Y4)]):-
	[X1,Y1,X2,Y2,X3,Y3,X4,Y4] in 1..4,
	X2 #= X1,
	Y2 #= Y1 - 1,
	X3 #= X1 - 1,
	Y3 #= Y1 - 1,
	X4 #= X1 + 1,
	Y4 #= Y1 - 1,
	label([X1,Y1,X2,Y2,X3,Y3,X4,Y4]).
pack(t,[(X1,Y1),(X2,Y2),(X3,Y3),(X4,Y4)]):-
	[X1,Y1,X2,Y2,X3,Y3,X4,Y4] in 1..4,
	X2 #= X1 + 1,
	Y2 #= Y1,
	X3 #= X1 + 1,
	Y3 #= Y1 - 1,
	X4 #= X1 + 1,
	Y4 #= Y1 + 1,
	label([X1,Y1,X2,Y2,X3,Y3,X4,Y4]).
pack(t,[(X1,Y1),(X2,Y2),(X3,Y3),(X4,Y4)]):-
	[X1,Y1,X2,Y2,X3,Y3,X4,Y4] in 1..4,
	X2 #= X1,
	Y2 #= Y1 + 1,
	X3 #= X1 - 1,
	Y3 #= Y1 + 1,
	X4 #= X1 + 1,
	Y4 #= Y1 + 1,
	label([X1,Y1,X2,Y2,X3,Y3,X4,Y4]).
pack(t,[(X1,Y1),(X2,Y2),(X3,Y3),(X4,Y4)]):-
	[X1,Y1,X2,Y2,X3,Y3,X4,Y4] in 1..4,
	X2 #= X1 - 1,
	Y2 #= Y1,
	X3 #= X1 - 1,
	Y3 #= Y1 - 1,
	X4 #= X1 - 1,
	Y4 #= Y1 + 1,
	label([X1,Y1,X2,Y2,X3,Y3,X4,Y4]).
pack(l,[(X1,Y1),(X2,Y2),(X3,Y3),(X4,Y4)]):-
	[X1,Y1,X2,Y2,X3,Y3,X4,Y4] in 1..4,
	X2 #= X1,
	Y2 #= Y1 - 1,
	X3 #= X1 + 1,
	Y3 #= Y1 - 1,
	X4 #= X1 + 2,
	Y4 #= Y1 - 1,
	label([X1,Y1,X2,Y2,X3,Y3,X4,Y4]).
pack(l,[(X1,Y1),(X2,Y2),(X3,Y3),(X4,Y4)]):-
	[X1,Y1,X2,Y2,X3,Y3,X4,Y4] in 1..4,
	X2 #= X1 + 1,
	Y2 #= Y1,
	X3 #= X1 + 1,
	Y3 #= Y1 + 1,
	X4 #= X1 + 1,
	Y4 #= Y1 + 2,
	label([X1,Y1,X2,Y2,X3,Y3,X4,Y4]).
pack(l,[(X1,Y1),(X2,Y2),(X3,Y3),(X4,Y4)]):-
	[X1,Y1,X2,Y2,X3,Y3,X4,Y4] in 1..4,
	X2 #= X1,
	Y2 #= Y1 + 1,
	X3 #= X1 - 1,
	Y3 #= Y1 + 1,
	X4 #= X1 - 2,
	Y4 #= Y1 + 1,
	label([X1,Y1,X2,Y2,X3,Y3,X4,Y4]).
pack(l,[(X1,Y1),(X2,Y2),(X3,Y3),(X4,Y4)]):-
	[X1,Y1,X2,Y2,X3,Y3,X4,Y4] in 1..4,
	X2 #= X1 - 1,
	Y2 #= Y1,
	X3 #= X1 - 1,
	Y3 #= Y1 - 1,
	X4 #= X1 - 1,
	Y4 #= Y1 - 2,
	label([X1,Y1,X2,Y2,X3,Y3,X4,Y4]).
pack(l,[(X1,Y1),(X2,Y2),(X3,Y3),(X4,Y4)]):-
	[X1,Y1,X2,Y2,X3,Y3,X4,Y4] in 1..4,
	X2 #= X1,
	Y2 #= Y1 - 1,
	X3 #= X1 - 1,
	Y3 #= Y1 - 1,
	X4 #= X1 - 2,
	Y4 #= Y1 - 1,
	label([X1,Y1,X2,Y2,X3,Y3,X4,Y4]).
pack(l,[(X1,Y1),(X2,Y2),(X3,Y3),(X4,Y4)]):-
	[X1,Y1,X2,Y2,X3,Y3,X4,Y4] in 1..4,
	X2 #= X1 - 1,
	Y2 #= Y1,
	X3 #= X1 - 1,
	Y3 #= Y1 + 1,
	X4 #= X1 - 1,
	Y4 #= Y1 + 2,
	label([X1,Y1,X2,Y2,X3,Y3,X4,Y4]).
pack(l,[(X1,Y1),(X2,Y2),(X3,Y3),(X4,Y4)]):-
	[X1,Y1,X2,Y2,X3,Y3,X4,Y4] in 1..4,
	X2 #= X1,
	Y2 #= Y1 + 1,
	X3 #= X1 + 1,
	Y3 #= Y1 + 1,
	X4 #= X1 + 2,
	Y4 #= Y1 + 1,
	label([X1,Y1,X2,Y2,X3,Y3,X4,Y4]).
pack(l,[(X1,Y1),(X2,Y2),(X3,Y3),(X4,Y4)]):-
	[X1,Y1,X2,Y2,X3,Y3,X4,Y4] in 1..4,
	X2 #= X1 - 1,
	Y2 #= Y1,
	X3 #= X1 - 1,
	Y3 #= Y1 + 1,
	X4 #= X1 - 1,
	Y4 #= Y1 + 2,
	label([X1,Y1,X2,Y2,X3,Y3,X4,Y4]).


	