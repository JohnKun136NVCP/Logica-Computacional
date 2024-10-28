:- op(500, fy, not).
:- op(400, xfy, and).
:- op(300, xfy, or).
:- op(200, xfy, implies).
components(X, Y, Z) :- X = (Y and Z).
components(X, Y, Z) :- X = (Y or Z).
components(X, Y, Z) :- X = (Y implies Z).
component(X, Y) :- X = not(Y).
singlestep([A and B | Rest], [A, B | Rest]). % Conjunción se expande
singlestep([A or B | Rest], [[A] | Rest]). % Disyunción se expande en listas
singlestep([A or B | Rest], [[B] | Rest]).
singlestep([not(A) | Rest], [not(A) | Rest]). % Negación se mantiene
