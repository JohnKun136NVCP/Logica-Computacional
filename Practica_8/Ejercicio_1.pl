:- op(200,xfy,and).
:- op(500,xfy,or).
:- op(1050,xfy,->).
:- op(400,fx,not).

formula(X):-
    atom(X).

formula(and(X,Y)):-
    formula(X),
    formula(Y).

formula(or(X,Y)):-
    formula(X),
    formula(Y).
formula(not(X)):-
    formula(X).

formula(->(X,Y)):-
    formula(X),
    formula(Y).
