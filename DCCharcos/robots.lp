time(1..bound).

action(up).
action(down).
action(left).
action(right).
action(wait).
action(liftBox).
action(liftFloat). % define accion levantar foltador
action(teleport). % define accion teletransportar

robotOn(R, X, Y + 1, T + 1) :- exec(R, up, T), robotOn(R, X, Y, T), time(T + 1).
robotOn(R, X, Y - 1, T + 1) :- exec(R, down, T), robotOn(R, X, Y, T), time(T + 1).
robotOn(R, X - 1, Y, T + 1) :- exec(R, left, T), robotOn(R, X, Y, T), time(T + 1).
robotOn(R, X + 1, Y, T + 1) :- exec(R, right, T), robotOn(R, X, Y, T), time(T + 1).
robotOn(R, X, Y, T + 1) :- exec(R, wait, T), robotOn(R, X, Y, T), time(T + 1).

3{boxOn(B, X - 1, Y, 1, T + 1); robotOn(R, X - 1, Y, T + 1); boxOnRobot(B, R, T + 1)}3 :- robotLiftBox(R, B, T), robotOn(R, X - 1, Y, T), time(T + 1), boxOn(B, X, Y, Z, T), robot(R), Z = 0. 
3{boxOn(B, X + 1, Y, 1, T + 1); robotOn(R, X + 1, Y, T + 1); boxOnRobot(B, R, T + 1)}3 :- robotLiftBox(R, B, T), robotOn(R, X + 1, Y, T), time(T + 1), boxOn(B, X, Y, Z, T), robot(R), Z = 0.
3{boxOn(B, X, Y - 1, 1, T + 1); robotOn(R, X, Y - 1, T + 1); boxOnRobot(B, R, T + 1)}3 :- robotLiftBox(R, B, T), robotOn(R, X, Y - 1, T), time(T + 1), boxOn(B, X, Y, Z, T), robot(R), Z = 0. 
3{boxOn(B, X, Y + 1, 1, T + 1); robotOn(R, X, Y + 1, T + 1); boxOnRobot(B, R, T + 1)}3 :- robotLiftBox(R, B, T), robotOn(R, X, Y + 1, T), time(T + 1), boxOn(B, X, Y, Z, T), robot(R), Z = 0. 

boxPickedUp(B, T) :- boxOnRobot(B, R, T). 
boxOn(B, X, Y, 0, T + 1) :- boxOn(B, X, Y, Z, T), Z = 0, not boxPickedUp(B, T + 1), time(T + 1), box(B).

boxOn(B, X, Y, 1, T) :- robotOn(R, X, Y, T), boxOnRobot(B, R, T), time(T).
boxOnRobot(B, R, T + 1) :- boxOnRobot(B, R, T), time(T + 1).

boxAdjacentToRobot(B, R, T) :- robotOn(R, X - 1, Y, T), boxOn(B, X, Y, Z, T), robot(R), time(T), box(B), Z = 0.
boxAdjacentToRobot(B, R, 0) :- robotOn(R, X - 1, Y, 0), boxOn(B, X, Y, Z, 0), robot(R), box(B), Z = 0.
boxAdjacentToRobot(B, R, T) :- robotOn(R, X + 1, Y, T), boxOn(B, X, Y, Z, T), robot(R), time(T), box(B), Z = 0.
boxAdjacentToRobot(B, R, 0) :- robotOn(R, X + 1, Y, 0), boxOn(B, X, Y, Z, 0), robot(R), box(B), Z = 0.
boxAdjacentToRobot(B, R, T) :- robotOn(R, X, Y - 1, T), boxOn(B, X, Y, Z, T), robot(R), time(T), box(B), Z = 0.
boxAdjacentToRobot(B, R, 0) :- robotOn(R, X, Y - 1, 0), boxOn(B, X, Y, Z, 0), robot(R), box(B), Z = 0.
boxAdjacentToRobot(B, R, T) :- robotOn(R, X, Y + 1, T), boxOn(B, X, Y, Z, T), robot(R), time(T), box(B), Z = 0.
boxAdjacentToRobot(B, R, 0) :- robotOn(R, X, Y + 1, 0), boxOn(B, X, Y, Z, 0), robot(R), box(B), Z = 0.

boxesAdjactentToRobot(R, T, N) :- robot(R), N = #count{B : boxAdjacentToRobot(B, R, T)}, time(T).
boxesAdjactentToRobot(R, 0, N) :- robot(R), N = #count{B : boxAdjacentToRobot(B, R, 0)}.

1 {exec(R, A, T) : action(A)} 1 :- robot(R), time(T + 1).

1{robotLiftBox(R, B, T): boxAdjacentToRobot(B, R, T)}1 :- exec(R, liftBox, T), time(T + 1), robot(R).

:- robotLiftBox(R, B, T), boxesAdjactentToRobot(R, T, N), N = 0.

:- robotLiftBox(R1, B, T), robotLiftBox(R2, B, T), R1 != R2. 

:- boxOnRobot(B1, R, T), boxOnRobot(B2, R, T), B1 != B2.

:- robotOn(R, X, Y, T), not rangeX(X).
:- robotOn(R, X, Y, T), not rangeY(Y).
:- boxOn(B, X, Y, Z, T), not rangeX(X).
:- boxOn(B, X, Y, Z, T), not rangeY(Y).
:- robotOn(R, X, Y, T), obstacle(X, Y).
:- boxOn(B, X, Y, Z, T), obstacle(X, Y).

:- robotOn(R1, X, Y, T), robotOn(R2, X, Y, T), R1 != R2.
:- boxOn(B1, X, Y, Z, T), boxOn(B2, X, Y, Z, T), B1 != B2, Z = 0.

:- robotOn(R1, X, Y, T), robotOn(R2, X + 1, Y, T), robotOn(R2, X, Y, T + 1), robotOn(R1, X + 1, Y, T + 1).
:- robotOn(R1, X, Y, T), robotOn(R2, X, Y + 1, T), robotOn(R2, X, Y, T + 1), robotOn(R1, X, Y + 1, T + 1).
:- robotOn(R, X, Y, T), boxOn(B, X, Y, Z, T), Z = 0, box(B), time(T).

at_goal(B, T) :- boxOn(B, X, Y, Z, T), goal(X, Y).
:- box(B), not at_goal(B, bound).


% P1: Charcos %%%%%%%%%%%

% Se hace que el flotador se mueva con el robot una vez recogido
3{floatOn(F, X - 1, Y, 1, T + 1); robotOn(R, X - 1, Y, T + 1); floatOnRobot(F, R, T + 1)}3 :- robotLiftFloat(R, F, T), robotOn(R, X - 1, Y, T), time(T + 1), floatOn(F, X, Y, Z, T), robot(R), Z = 0. 
3{floatOn(F, X + 1, Y, 1, T + 1); robotOn(R, X + 1, Y, T + 1); floatOnRobot(F, R, T + 1)}3 :- robotLiftFloat(R, F, T), robotOn(R, X + 1, Y, T), time(T + 1), floatOn(F, X, Y, Z, T), robot(R), Z = 0.
3{floatOn(F, X, Y - 1, 1, T + 1); robotOn(R, X, Y - 1, T + 1); floatOnRobot(F, R, T + 1)}3 :- robotLiftFloat(R, F, T), robotOn(R, X, Y - 1, T), time(T + 1), floatOn(F, X, Y, Z, T), robot(R), Z = 0. 
3{floatOn(F, X, Y + 1, 1, T + 1); robotOn(R, X, Y + 1, T + 1); floatOnRobot(F, R, T + 1)}3 :- robotLiftFloat(R, F, T), robotOn(R, X, Y + 1, T), time(T + 1), floatOn(F, X, Y, Z, T), robot(R), Z = 0. 

% Se hace que Z sea 0 mientras no se recoje el flotador
floatPickedUp(F, T) :- floatOnRobot(F, R, T). 
floatOn(F, X, Y, 0, T + 1) :- floatOn(F, X, Y, Z, T), Z = 0, not floatPickedUp(F, T + 1), time(T + 1), float(F).

% Se hace que el flotador se mantenga en el robot al pasar el tiempo
floatOn(F, X, Y, 1, T) :- robotOn(R, X, Y, T), floatOnRobot(F, R, T), time(T).
floatOnRobot(F, R, T + 1) :- floatOnRobot(F, R, T), time(T + 1).

% Se definen todas las combinaciones de posiciones adjacentes del flotador al robot, para T=T y T=0
floatAdjacentToRobot(F, R, T) :- robotOn(R, X - 1, Y, T), floatOn(F, X, Y, Z, T), robot(R), time(T), float(F), Z = 0.
floatAdjacentToRobot(F, R, 0) :- robotOn(R, X - 1, Y, 0), floatOn(F, X, Y, Z, 0), robot(R), float(F), Z = 0.
floatAdjacentToRobot(F, R, T) :- robotOn(R, X + 1, Y, T), floatOn(F, X, Y, Z, T), robot(R), time(T), float(F), Z = 0.
floatAdjacentToRobot(F, R, 0) :- robotOn(R, X + 1, Y, 0), floatOn(F, X, Y, Z, 0), robot(R), float(F), Z = 0.
floatAdjacentToRobot(F, R, T) :- robotOn(R, X, Y - 1, T), floatOn(F, X, Y, Z, T), robot(R), time(T), float(F), Z = 0.
floatAdjacentToRobot(F, R, 0) :- robotOn(R, X, Y - 1, 0), floatOn(F, X, Y, Z, 0), robot(R), float(F), Z = 0.
floatAdjacentToRobot(F, R, T) :- robotOn(R, X, Y + 1, T), floatOn(F, X, Y, Z, T), robot(R), time(T), float(F), Z = 0.
floatAdjacentToRobot(F, R, 0) :- robotOn(R, X, Y + 1, 0), floatOn(F, X, Y, Z, 0), robot(R), float(F), Z = 0.

% Se cuentan los flotadores adjacentes al robot para cualquier T
floatesAdjactentToRobot(R, T, N) :- robot(R), N = #count{F : floatAdjacentToRobot(F, R, T)}, time(T).
floatesAdjactentToRobot(R, 0, N) :- robot(R), N = #count{F : floatAdjacentToRobot(F, R, 0)}.

% Se define la función de la acción de recoger flotador para flotadores adjacentes
1{robotLiftFloat(R, F, T): floatAdjacentToRobot(F, R, T)}1 :- exec(R, liftFloat, T), time(T + 1), robot(R).

% Se evita recoger flotadores si no hay adjacentes al robot
:- robotLiftFloat(R, F, T), floatesAdjactentToRobot(R, T, N), N = 0.

% Se evita que dos robots recogan el mismo flotador
:- robotLiftFloat(R1, F, T), robotLiftFloat(R2, F, T), R1 != R2. 

% Se evita que un robot recoja dos flotadores
:- floatOnRobot(F1, R, T), floatOnRobot(F2, R, T), F1 != F2.

:- floatOn(F, X, Y, Z, T), not rangeX(X).   % Se evitan flotadores fuera de rango en X
:- floatOn(F, X, Y, Z, T), not rangeY(Y).   % Se evitan flotadores fuera de rango en Y
:- floatOn(F, X, Y, Z, T), obstacle(X, Y).  % Se evitan flotadores sobre obstaculos

% Se evitan flotadores en la misma posición
:- floatOn(F1, X, Y, Z, T), floatOn(F2, X, Y, Z, T), F1 != F2, Z = 0.   

% Se evita que un robot pase sobre un flotador 
:- robotOn(R, X, Y, T), floatOn(F, X, Y, Z, T), Z = 0, float(F), time(T).

% Se evita que un robot pase sobre el agua sin un flotador
floatOnRobot_aux(R, T):- floatOnRobot(F, R, T), robot(R), float(F), time(T).    % funcion auxiliar si es que robot tiene flotador
:- robotOn(R, X, Y, T), not floatOnRobot_aux(R, T), water(X, Y), time(T).       % un robot sin flotador no puede estar en agua


% P2: Portales %%%%%%%%%%

% Se definen todas las combinaciones de posiciones adjacentes del portal al robot, para T=T y T=0
portalAdjacentToRobot(X1 - 1, Y1, X1, Y1, R, T) :- robotOn(R, X1 - 1, Y1, T), portal(X1, Y1, X2, Y2), robot(R), time(T), rangeX(X2), rangeY(Y2).
portalAdjacentToRobot(X1 + 1, Y1, X1, Y1, R, T) :- robotOn(R, X1 + 1, Y1, T), portal(X1, Y1, X2, Y2), robot(R), time(T), rangeX(X2), rangeY(Y2).
portalAdjacentToRobot(X1, Y1 - 1, X1, Y1, R, T) :- robotOn(R, X1, Y1 - 1, T), portal(X1, Y1, X2, Y2), robot(R), time(T), rangeX(X2), rangeY(Y2).
portalAdjacentToRobot(X1, Y1 + 1, X1, Y1, R, T) :- robotOn(R, X1, Y1 + 1, T), portal(X1, Y1, X2, Y2), robot(R), time(T), rangeX(X2), rangeY(Y2).
portalAdjacentToRobot(X1 - 1, Y1, X1, Y1, R, 0) :- robotOn(R, X1 - 1, Y1, 0), portal(X1, Y1, X2, Y2), robot(R), rangeX(X2), rangeY(Y2).
portalAdjacentToRobot(X1 + 1, Y1, X1, Y1, R, 0) :- robotOn(R, X1 + 1, Y1, 0), portal(X1, Y1, X2, Y2), robot(R), rangeX(X2), rangeY(Y2).
portalAdjacentToRobot(X1, Y1 - 1, X1, Y1, R, 0) :- robotOn(R, X1, Y1 - 1, 0), portal(X1, Y1, X2, Y2), robot(R), rangeX(X2), rangeY(Y2).
portalAdjacentToRobot(X1, Y1 + 1, X1, Y1, R, 0) :- robotOn(R, X1, Y1 + 1, 0), portal(X1, Y1, X2, Y2), robot(R), rangeX(X2), rangeY(Y2).

% Se define la función de la acción de teletransportarse para portales adjacentes
robotOn(R, X2, Y2, T + 1) :- exec(R, teleport, T), robotOn(R, X, Y, T), portalAdjacentToRobot(X, Y, X1, Y1, R, T), portal(X1, Y1, X2, Y2), time(T + 1).


#show time/1.
#show robotOn/4.
#show boxOn/5.
#show obstacle/2.
#show rangeX/1.
#show rangeY/1.
#show goal/2.
#show water/2.
#show floatOn/5.
#show portal/4.

% Para copia enterminal
%clingo robots.lp tests/test7.lp -c bound=6 | python process.py
%clingo robots.lp tests/test4.lp -c bound=3