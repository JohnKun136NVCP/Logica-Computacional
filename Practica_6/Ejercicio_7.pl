% Rango r de una fórmula
rango(P, 0) :- atom(P).
rango(neg(P), 0) :- atom(P).
rango(neg(X), R) :-
    rango(X, R).
rango(and(X, Y), R) :-
    rango(X, RX),
    rango(Y, RY),
    R is RX + RY + 1.
rango(or(X, Y), R) :-
    rango(X, RX),
    rango(Y, RY),
    R is RX + RY + 1.
rango(implies(X, Y), R) :-
    rango(X, RX),
    rango(Y, RY),
    R is RX + RY + 1.
