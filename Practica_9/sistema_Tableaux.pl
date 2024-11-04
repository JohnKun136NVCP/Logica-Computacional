:- op(500, fy, not).
:- op(400, xfy, and).
:- op(300, xfy, or).
:- op(200, xfy, implies).

components(X, Y, Z) :- X = (Y and Z).
components(X, Y, Z) :- X = (Y or Z).
components(X, Y, Z) :- X = (Y implies Z).
component(X, Y) :- X = not(Y).

singlestep([A and B | Rest], [A, B | Rest]).
singlestep([A or B | Rest], [A | Rest]).
singlestep([A or B | Rest], [B | Rest]).
singlestep([not(A) | Rest], [not(A) | Rest]).
singlestep([Literal | Rest], [Literal | Rest]) :- \+ (Literal = (_ and _)), \+ (Literal = (_ or _)), \+ (Literal = not(_)).

flatten([], []).
flatten([Head|Tail], FlatList) :-
    flatten(Head, FlatHead),
    flatten(Tail, FlatTail),
    append(FlatHead, FlatTail, FlatList).
flatten(L, [L]).
%% Función de expancion Ejercicio 1.
expand([], []).
expand([H|T], Result) :-
    singlestep([H|T], Temp),
    flatten(Temp, FlatTemp),
    ( FlatTemp == [H|T] -> Result = [H|T]; expand(FlatTemp, Result) ).

% Verifica si una lista contiene una literal y su negación
member_negation(X, [not(X) | _T]).
member_negation(X, [_H | T]) :- member_negation(X, T).
member_negation(not(X), [X | _T]).
member_negation(not(X), [_H | T]) :- member_negation(not(X), T).

% Verifica si todas las ramas de un árbol Tableaux se cierran. Ejercicio 2.
closed([]).
closed([Branch | Rest]) :-
    member_negation(_Lit, Branch),
    closed(Rest).

% Verifica si una rama no se cierra
not_closed(Branch) :-
    \+ member_negation(_Lit, Branch).

% Verifica si el árbol Tableaux no se cancela. Ejercicio 3.
sat(Formula) :-
    expand([Formula], ExpandedTree),
    member(Branch, ExpandedTree),
    not_closed(Branch).

% Define el modelo, que es una fórmula satisfactible y una rama que sobrevive. Ejercicio 4.
model(Formula, Branch) :-
    sat(Formula),
    expand([Formula], ExpandedTree),
    member(Branch, ExpandedTree),
    survives(Branch).

% Verifica si una rama sobrevive
survives(Branch) :-
    \+ member_negation(_Lit, Branch).

% Define el predicado theorem/1. Ejercicio 5.
theorem(X) :-
    expand([not(X)], ExpandedTree),
    closed(ExpandedTree).
