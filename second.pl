%Tadas Martinkus PS2
%2.1

studentas(tadas, 4).
studentas(ernesta, 4). 
studentas(karolis, 1). 
studentas(antanas, 4). 
studentas(sarunas, 3). 
studentas(migle, 3).
studentas(agne, 2).
studentas(tomas, 2). 
studentas(darius, 1). 
studentas(kazys, 1).

yraVyresnis(tadas, ernesta).
yraVyresnis(ernesta, karolis).
yraVyresnis(karolis, antanas).
yraVyresnis(ernesta, sarunas).
yraVyresnis(sarunas, migle).
yraVyresnis(migle, agne).
yraVyresnis(agne, tomas).
yraVyresnis(tomas, darius).
yraVyresnis(darius, kazys).

arVyresnis(Stud1, Stud2) :-
	toPatiesKurso(Stud1, Stud2), vyresnis(Stud1, Stud2).
	
toPatiesKurso(Stud1, Stud2):- 
	studentas(Stud1, Kursas1), studentas(Stud2, Kursas2), Kursas1 = Kursas2.
	
vyresnis(Stud1, Stud2):- 
	yraVyresnis(Stud1, Stud2).
vyresnis(Stud1, Stud2):- 
	yraVyresnis(Stud1, Stud3), vyresnis(Stud3, Stud2).


%5.2
divit_mod(Dividend, Divisor, Q):-
	Dividend < 0, MDividend is -Dividend, divit_positive(MDividend, Divisor, MQ), Q is -MQ.
divit_mod(Dividend, Divisor, Q):-
	Dividend >= 0, Divisor < 0, MDivisor is -Divisor, divit_positive(Dividend, MDivisor, MQ), Q is -MQ.
divit_mod(Dividend, Divisor, Q):-
	Dividend >= 0, Divisor > 0, divit_positive(Dividend, Divisor, Q).
divit_mod(Dividend, Divisor, Q):-
	Dividend < 0, Divisor < 0, MDividend is -Dividend, MDivisor is -Divisor, divit_positive(MDividend, MDivisor, Q).

divit_positive(Dividend, Divisor, Acc, Acc) :-
    Dividend < Divisor.

divit_positive(Dividend , Divisor, Acc, Q) :-
    Dividend >= Divisor,
    D1 is Dividend - Divisor,
    Acc1 is Acc + 1,
    divit_positive(D1, Divisor, Acc1, Q).