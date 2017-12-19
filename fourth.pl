:- use_module(library(clpfd)).
%build([4,4],[[1,2],[1,2],[1,2],[1,2],[4,2]]) GOOD
%build([4,4],[[4,2],[1,2],[1,2],[1,2],[1,2]]) GOOD
%build([2,2],[[1,1],[1,1],[1,2]]) GOOD
%build([4,4],[[1,2],[4,2],[1,2],[1,2],[1,2]]) GOOD

%build([4,4],[[3,3],[2,2],[1,1],[1,1],[1,1]]). FAIL
%build([4,4],[[3,3],[1,1],[1,1],[1,1],[1,1],[1,1],[1,1],[1,1]]). GOOD

%build([5,1],[[2,1],[2,2],[2,1],[2,1],[1,1],[1,1]]). GOOD
%main
build(BigR, SmallR) :-
	sameOrBiggerArea(BigR, SmallR),
	bubblesort(SmallR, SmallRSorted),
	place(BigR, SmallRSorted, ResultList),
	maplist(=.., ResultList, ResultList_),
	%convertToStandandList(ResultList_, convertedResultList),
	%sameOrBiggerArea(BigR, convertedResultList),
	printResult(BigR, ResultList_).

%is possible to fit
sameOrBiggerArea(BigR, SmallR) :-
	sumEdge(SmallR, SumPlot),
	getArea(BigR, BigPlot),
	BigPlot =< SumPlot.
	
convertToStandandList([], []).
convertToStandandList([Head|Tail], NewR) :-
	convertToStandandList(Tail, NewR_),
	getR(Head, NewHead),
	NewR = [NewHead|NewR_].
	
getR([_, _, Width, _, Height], [Width, Height]).
	
sumEdge([], 0).
sumEdge([Head|Tail], SumPlot) :-
	sumEdge(Tail, SumPlot_),
	getArea(Head, Plot),
	SumPlot is SumPlot_ + Plot.

%sort
bubblesort(List, SortedList) :-
    swap(List, List1), !,
    bubblesort(List1,SortedList).
bubblesort(List, List).

swap([X,Y|Rest],[Y,X|Rest]) :-
	getArea(X, PlotX),
	getArea(Y, PlotY),
    PlotX > PlotY, !.
swap([Z|Rest],[Z|Rest1]) :-
    swap(Rest, Rest1).	
	
%solve
place(_, [], []).
place(BigR, [Head|Tail], ResultList) :-
	place(BigR, Tail, ResultList_),
	placeOne(BigR, Head, R, 0, 0, ResultList_), !,
	ResultList = [R|ResultList_].
place(BigR, [_|Tail], ResultList) :-
	place(BigR, Tail, ResultList_),
	ResultList = ResultList_.	

placeOne([BigW, BigH], [Width, Height], R, X, Y, ResultList) :-
	BigW >= Width,
	BigH >= Height,
	R = r(X, Width, Y, Height),
	disjoint2([R|ResultList]).
placeOne([BigW, BigH], [Width, Height], R, X, Y, ResultList) :-
	BigW > X + Width,
	X_ is X + 1,
	placeOne([BigW, BigH], [Width, Height], R, X_, Y, ResultList).
placeOne([BigW, BigH], [Width, Height], R, X, Y, ResultList) :-
	BigH > Y + Height,
	Y_ is Y + 1,
	X = 0,
	placeOne([BigW, BigH], [Width, Height], R, X, Y_, ResultList).

%print	
printResult(R, RectList) :-
	writeln('<svg style="fill:white;stroke:blue;stroke-width:2;overflow:visible">'),
	write('<rect '),
	getEdge(R, Width, Height),
	printR([0, 0, Width, 0, Height]),
	writeln('fill="black" stroke="red" stroke-width="5"/>'),
	printResult_(RectList),
	writeln('</svg>').

printResult_([]).
printResult_([Head|Tail]) :-
	printResult_(Tail),
	write('<rect '),
	printR(Head),
	writeln('/>').

printR([_, X, W, Y, H]) :-
	X_ is X * 50,
	write('x="'), write(X_), write('" '),
	Y_ is Y * 50,
	write('y="'), write(Y_), write('" '),
	W_ is W * 50,
	write('width="'), write(W_), write('" '),
	H_ is H * 50,
	write('height="'), write(H_), write('"').

%other
getEdge([W, H], Width, Height) :-
	Width = W,
	Height = H.	

getArea([W, H], Plot):-
	Plot is W * H.	
