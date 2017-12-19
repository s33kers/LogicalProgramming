%Tadas Martinkus 
%1.3
lyginiai([Last]) :- !, lyginis(Last).
lyginiai([Head|KasLiko]) :- lyginis(Head), lyginiai(KasLiko).
lyginis(Numb) :- Numb mod 2 =:= 0.

%2.1
min([Head|Tail], M):-
	min_(Tail, Head, M).
	
min_([], M, M) :- !.
min_([Head|Tail], M0, M1) :-
	Head < M0, !,
	min_(Tail, Head, M1).
min_([Head|Tail], M0, M1) :-
	Head >= M0,
	min_(Tail, M0, M1).


%3.10
%get set of dublciate elements in a list
kartojasi([], []) :- !.
kartojasi([Head|Tail], Rez) :-
	dub(Head, Tail), !,
	kartojasi(Tail, Rez1),
	addToList(Head, Rez1, Rez).	
kartojasi([Head|Tail], Rez) :-
	not(dub(Head, Tail)),
	kartojasi(Tail, Rez1),
	Rez = Rez1.	
	
%check if element is a member of list
dub(Elem, [Head|Tail]) :-
	yraNarys(Elem, Head, Tail).
yraNarys(Elem, Elem, _) :- !.
yraNarys(Elem, _, [Head|Tail]) :-
	yraNarys(Elem, Head, Tail).
	
%add only if it is not dublicate in rezult list	
addToList(Elem, List, Rez) :-
	not(dub(Elem, List)), !,
	Rez = [Elem|List].
addToList(Elem, List, Rez) :-
	dub(Elem, List),
	Rez = List.
	
%4.1
kart([Head|Tail], Max, Rez) :-
	same(Head, Tail, 1, Max, Rez1),
	Rez = Rez1.
%perfect, keep going
same(Current, [Head|Tail], Inc, Max, Rez) :-
	compare(Current, Head), !,
	same(Head, Tail, Inc+1, Max, Rez).
%perfect, found it
same(Current, [Head|Tail], Inc, Max, Rez) :-
	not(compare(Current, Head)),
	Inc =:= Max, !,
	same(Head, Tail, 1, Max, Rez1),
	Rez = [Current|Rez1].
%ne toks pat
same(Current, [Head|Tail], _, Max, Rez) :-
	not(compare(Current, Head)), !,
	same(Head, Tail, 1, Max, Rez).
same(Current, [], Inc, Max, Rez) :-
	Inc =:= Max, !,
	Rez1 = [],
	Rez = [Current|Rez1].
same(_, [], _, _, []).
compare(A, A).