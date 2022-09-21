ciudad("Talca").
ciudad("Concepcion").
ciudad("Santiago").
ciudad("Valparaiso").
ciudad("Antofagasta").

dispositivo("Mac").
dispositivo("Papel").
dispositivo("ENIAC").
dispositivo("Tablet").
dispositivo("Nokia").

lenguaje("Javascript").
lenguaje("C#").
lenguaje("Ruby").
lenguaje("Clingo").
lenguaje("Python").

bebestible("Cafe").
bebestible("RedBull").
bebestible("Mate").
bebestible("Agua").
bebestible("Gatorade").

musica("Rock Latino").
musica("Jazz").
musica("Cumbia Villera").
musica("LoFi").
musica("De Ascensor").

% Recuerda que solo puede haber una combinación de ciudad, 
% lenguaje, musica, dispositivo y bebestible por persona.
% Define eso aquí antes de empezar con las pistas
1{combinacion(P, C, D, L, B, M): ciudad(C),dispositivo(D),lenguaje(L),bebestible(B),musica(M)}1:- programador(P).
1{combinacion(P, C, D, L, B, M): programador(P),dispositivo(D),lenguaje(L),bebestible(B),musica(M)}1:- ciudad(C).
1{combinacion(P, C, D, L, B, M): programador(P),ciudad(C),lenguaje(L),bebestible(B),musica(M)}1:- dispositivo(D).
1{combinacion(P, C, D, L, B, M): programador(P),ciudad(C),dispositivo(D),bebestible(B),musica(M)}1:- lenguaje(L).
1{combinacion(P, C, D, L, B, M): programador(P),ciudad(C),dispositivo(D),lenguaje(L),musica(M)}1:- bebestible(B).
1{combinacion(P, C, D, L, B, M): programador(P),ciudad(C),dispositivo(D),lenguaje(L),bebestible(B)}1:- musica(M).


% Pista 1: Te la damos nosotros ;)
programador(1..5).

% Pista 2:
:- combinacion(P, C, D, L, B, M), C=="Talca", D!="Papel".

% Pista 3:
:- combinacion(P, C, D, L, B, M), C=="Valparaiso", M!="LoFi".

% Pista 4:
:- combinacion(P, C, D, L, B, M), L=="Python", D!="ENIAC".

% Pista 5:
:- combinacion(P, C, D, L, B, M), C=="Antofagasta", L!="Javascript".

% Pista 6:
:- combinacion(P, C, D, L, B, M), combinacion(P1, C1, D1, L1, B1, M1), D=="Tablet", D1=="ENIAC", P1!=P+1.

% Pista 7:
:- combinacion(P, C, D, L, B, M), B=="Mate", M!="Cumbia Villera".

% Pista 8:
:- combinacion(P, C, D, L, B, M), B=="Cafe", D!="Mac".

% Pista 9:
:- combinacion(P, C, D, L, B, M), P==3, L!="C#".

% Pista 10:
:- combinacion(P, C, D, L, B, M), P==1, C!="Santiago".

% Pista 11:
:- combinacion(P, C, D, L, B, M), combinacion(P1, C1, D1, L1, B1, M1), B=="RedBull", M1=="Jazz", P-P1>1.
:- combinacion(P, C, D, L, B, M), combinacion(P1, C1, D1, L1, B1, M1), B=="RedBull", M1=="Jazz", P-P1<-1.
:- combinacion(P, C, D, L, B, M), combinacion(P1, C1, D1, L1, B1, M1), B=="RedBull", M1=="Jazz", P==P1.

% Pista 12:
:- combinacion(P, C, D, L, B, M), combinacion(P1, C1, D1, L1, B1, M1), B=="Cafe", M1=="Rock Latino", P-P1>1.
:- combinacion(P, C, D, L, B, M), combinacion(P1, C1, D1, L1, B1, M1), B=="Cafe", M1=="Rock Latino", P-P1<-1.
:- combinacion(P, C, D, L, B, M), combinacion(P1, C1, D1, L1, B1, M1), B=="Cafe", M1=="Rock Latino", P==P1.

% Pista 13:
:- combinacion(P, C, D, L, B, M), B=="Gatorade", L!="Ruby".

% Pista 14:
:- combinacion(P, C, D, L, B, M), C=="Concepcion", B!="Agua".

% Pista 15:
:- combinacion(P, C, D, L, B, M), combinacion(P1, C1, D1, L1, B1, M1), C=="Santiago", D1=="Nokia", P-P1>1.
:- combinacion(P, C, D, L, B, M), combinacion(P1, C1, D1, L1, B1, M1), C=="Santiago", D1=="Nokia", P-P1<-1.
:- combinacion(P, C, D, L, B, M), combinacion(P1, C1, D1, L1, B1, M1), C=="Santiago", D1=="Nokia", P==P1.


% Descomenta la siguiente linea cuando hayas creado
% el predicado combinacion(P, C, D, L, B, M).

#show combinacion/6.