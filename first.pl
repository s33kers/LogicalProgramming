%DOMAINS
%vardas = symbol
%lytis = symbol
%amzius = integer
%pomegis = symbol

%PREDICATES
%asmuo(symbol, symbol, integer, symbol)
%mama(asmuo, asmuo)
%pora(asmuo, asmuo)

%CLAUSES
asmuo(tadas, vyr,  22, kompas).
asmuo(ernesta, mot, 23, sokis).
asmuo(ieva, mot, 14, sokis).
asmuo(ricardas, vyr, 48, sodyba).
asmuo(ausra, mot, 45, sokis).
asmuo(robertas, vyr, 72, sodyba).
asmuo(nijole, mot, 71, sodyba).
asmuo(genovaite, mot, 70, sodyba).
asmuo(bronius, vyr, 89, sodyba).
asmuo(gailute, mot, 50, sodyba).
asmuo(pajtim, vyr, 48, kompas).
asmuo(felicija, mot, 102, sodyba).
asmuo(mr, vyr, 110, sodyba).
asmuo(irena, mot, 72, sodyba).
asmuo(antanas, vyr, 74, sodyba).
asmuo(rita, mot, 55, sodyba).
asmuo(saulius, vyr, 56, sodyba).
asmuo(zilvinas, vyr, 27, kompas).
asmuo(egle, mot, 25, sokis).


mama(ausra, tadas).
mama(ausra, ieva).
mama(nijole, ricardas).
mama(genovaite, ausra).
mama(genovaite, gailute).
mama(felicija, irena).
mama(nijole, saulius).
mama(rita, zilvinas).
mama(rita, egle).

pora(ernesta, tadas).
pora(ausra, ricardas).
pora(nijole, robertas).
pora(genovaite, bronius).
pora(gailute, pajtim).
pora(felicija, mr).
pora(irena, antanas).
pora(rita, saulius).

%23
marti(Marti, AnytaSesuras):-
	pora(Marti, Sunus), 
	(mama(AnytaSesuras, Sunus); mama(Mama, Sunus), pora(Mama, AnytaSesuras)).

%24
pusbrolis(Pusbrolis, PusbrolisPussesere):-	
	asmuo(Pusbrolis, vyr, _, _), mama(Mama, Pusbrolis), 
	((mama(Mociute, Mama), mama(Mociute, Teta), mama(Teta, PusbrolisPussesere));
	(mama(Mociute, Mama), mama(Mociute, Dede), pora(Teta, Dede), mama(Teta, PusbrolisPussesere));
	(pora(Mama, Tetis), mama(Mociute, Tetis), mama(Mociute, Teta), mama(Teta, PusbrolisPussesere));
	(pora(Mama, Tetis), mama(Mociute, Tetis), mama(Mociute, Dede), pora(Teta, Dede), mama(Teta, PusbrolisPussesere))), Pusbrolis \= PusbrolisPussesere.
	
%31
vps(Vyras):-
	asmuo(Vyras, vyr, Y1, _), Y1 > 25, Y1 < 35.
	
%39
panasus_amzius(Y1, Y2) :-
	Y1-Y2 < 3, Y1-Y2 > -3.
 
trys_draugai(Draugas1, Draugas2, Draugas3):-
	asmuo(Draugas1, _, Y1, P), asmuo(Draugas2, _, Y2, P), asmuo(Draugas3, _, Y3, P),
	Draugas1 \= Draugas2, Draugas2 \= Draugas3, Draugas1 \= Draugas3,
	panasus_amzius(Y1, Y2),
	panasus_amzius(Y1, Y3),
	panasus_amzius(Y2, Y3).