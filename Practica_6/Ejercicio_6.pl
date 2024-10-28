% Grado d de una fórmula
grado(P, 0) :- atom(P).
grado(neg(X), D) :-
    grado(X, DX),
    D is DX + 1.
grado(and(X, Y), D) :-
    grado(X, DX),
    grado(Y, DY),
    D is DX + DY.
grado(or(X, Y), D) :-
    grado(X, DX),
    grado(Y, DY),
    D is DX + DY.
grado(implies(X, Y), D) :-
    grado(X, DX),
    grado(Y, DY),
    D is DX + DY.
