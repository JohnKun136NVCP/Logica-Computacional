:- op(500, fy, not).
:- op(400, xfy, and).
:- op(300, xfy, or).
:- op(200, xfy, implies).

conjunctive(A and B) :- !.
conjunctive(not (A implies B)) :- conjunctive(A), conjunctive(B).
conjunctive(not (A or B)) :- conjunctive(A), conjunctive(B).
conjunctive(not (A)) :- conjunctive(A).


conjunctive(not (not A)) :- conjunctive(A).

disjunctive(A or B) :- !.
disjunctive(A implies B) :- disjunctive(A), disjunctive(B).
disjunctive(not (A and B)) :- disjunctive(A), disjunctive(B).
disjunctive(not (A)) :- disjunctive(A).


disjunctive(not (not A)) :- disjunctive(A).

unitary(not (not A)) :- unitary(A).
unitary(not (true)).
unitary(not (false)).
