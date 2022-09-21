% Actividad 1.

% Los cursos aprobados no pueden tener un semestre asignado.
:- course_on(C,S), approved_at(C,S).                % Se eliminan combinaciones de cursos C aprobados el semestre S
:- course_on(C,S1), approved_at(C,S2), S1 != S2.    % Se eliminan combinaciones de cursos C aprobados en cualquier otro semestre
:- course_on(C1,S), approved_at(C2,S), C1 != C2.    % Se eliminan combinaciones de semestes S con cursos aprobados 


% Todos los cursos que no estén aprobados deben tener un único semestre asignado.
% Se fuerza que el numero de cursos con semestre asignado debe ser igual al número de cursos sin aprobar
:- N1 = #count{C: approved_at(C,S)}, N2 = #count{C: course_on(C,S)}, N3 = #count{C: course(C)}, N3 - N1 != N2. 
0{course_on(C,S): semester(S)}1 :- course(C).   % Se limitan las combinaciones a máximo una por curso


% Los semestres no pueden tener más de 5 ramos asignados.
0{course_on(C,S): course(C)}5 :- semester(S).   % Se limitan las combinaciones a máximo cinco por semestre


% Los cursos que sólo se dictan en semestres impares no pueden estar asignados a 
% semestres pares y los cursos que sólo se dictan en semestres pares no pueden 
% ser asignados a semestres impares.
% Se eliminan cursos de solo segundo semestre de semestres impares
:- course_on(C,S), not dictates_on(C,1), dictates_on(C,2),  S\2 == 1.  
% Se eliminan cursos de solo primer semestre de semestres pares
:- course_on(C,S), not dictates_on(C,2), dictates_on(C,1),  S\2 == 0.  



% Actividad 2.

% Si un ramo A es prerrequisito de un ramo B, entonces el ramo A no puede ser 
% asignado en un semestre igual o posterior al del ramo B.
% Se eliminan prerrequisitos en semestres iguales o posteriores 
:- course_on(C1, S1), course_on(C2, S2), prerequisite(C1, C2), S1 >= S2.


% Si un ramo A es correquisito de un ramo B, entonces el ramo A no puede ser 
% asignado en un semestre posterior al del ramo B.
% Se eliminan correquisitos en semestres posteriores 
:- course_on(C1, S1), course_on(C2, S2), corequisite(C1, C2), S1 > S2.


% Descomenta las siguientes lineas para poder usar el visualizador.

#show invalid_course/1.
#show course_on/2.
#show prerequisite/2.
#show corequisite/2.
#show dictates_on/2.
#show approved_at/2.

% Para copiar en la terminal
% clingo -n 1 base.lp tests/test6.lp -c bound=4
% clingo -n 1 base.lp tests/test7.lp -c bound=8 | py process.py -o "output.json"
