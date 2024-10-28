von_neumann(0, []).
von_neumann(s(N), L) :-
    von_neumann(N, LN),
    append(LN, [LN], L).
% Ejemplo de uso
% von_neumann(0, L0), von_neumann(s(0), L1), von_neumann(s(s(0)), L2).
