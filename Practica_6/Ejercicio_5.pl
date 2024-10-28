% Conversión a forma normal conjuntiva (FNC)
to_cnf(true, true) :- !.
to_cnf(false, false) :- !.
to_cnf(A, A) :- atom(A), !.
to_cnf(neg(A), neg(CNF)) :-
    to_cnf(A, CNF_A),
    push_negation(CNF_A, CNF).
to_cnf(and(A, B), and(CNF_A, CNF_B)) :-
    to_cnf(A, CNF_A),
    to_cnf(B, CNF_B).
to_cnf(or(A, B), CNF) :-
    to_cnf(A, CNF_A),
    to_cnf(B, CNF_B),
    distribute_cnf(CNF_A, CNF_B, CNF).

% Poner negaciones hacia dentro
push_negation(true, false).
push_negation(false, true).
push_negation(neg(A), A) :- atom(A), !.
push_negation(and(A, B), or(NA, NB)) :-
    push_negation(neg(A), NA),
    push_negation(neg(B), NB).
push_negation(or(A, B), and(NA, NB)) :-
    push_negation(neg(A), NA),
    push_negation(neg(B), NB).

% Distributividad
distribute_cnf(and(A, B), C, and(Dist_A, Dist_B)) :-
    distribute_cnf(A, C, Dist_A),
    distribute_cnf(B, C, Dist_B).
distribute_cnf(A, and(B, C), and(Dist_A, Dist_B)) :-
    distribute_cnf(A, B, Dist_A),
    distribute_cnf(A, C, Dist_B).
distribute_cnf(A, B, or(A, B)).
% Conversión a forma normal disyuntiva (FND)
to_dnf(true, true) :- !.
to_dnf(false, false) :- !.
to_dnf(A, A) :- atom(A), !.
to_dnf(neg(A), neg(DNF)) :-
    to_dnf(A, DNF_A),
    push_negation_dnf(DNF_A, DNF).
to_dnf(or(A, B), or(DNF_A, DNF_B)) :-
    to_dnf(A, DNF_A),
    to_dnf(B, DNF_B).
to_dnf(and(A, B), DNF) :-
    to_dnf(A, DNF_A),
    to_dnf(B, DNF_B),
    distribute_dnf(DNF_A, DNF_B, DNF).

% Poner negaciones hacia dentro
push_negation_dnf(true, false).
push_negation_dnf(false, true).
push_negation_dnf(neg(A), A) :- atom(A), !.
push_negation_dnf(or(A, B), and(NA, NB)) :-
    push_negation_dnf(neg(A), NA),
    push_negation_dnf(neg(B), NB).
push_negation_dnf(and(A, B), or(NA, NB)) :-
    push_negation_dnf(neg(A), NA),
    push_negation_dnf(neg(B), NB).

% Distributividad para FND
distribute_dnf(or(A, B), C, or(Dist_A, Dist_B)) :-
    distribute_dnf(A, C, Dist_A),
    distribute_dnf(B, C, Dist_B).
distribute_dnf(A, or(B, C), or(Dist_A, Dist_B)) :-
    distribute_dnf(A, B, Dist_A),
    distribute_dnf(A, C, Dist_B).
distribute_dnf(A, B, and(A, B)).
