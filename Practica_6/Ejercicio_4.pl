% Predicado que es verdadero si X aparece solo una vez en la lista L
onlymember(X, L) :-
    appendone(X, Rest, L),
    \+ member(X, Rest).

% Definición de appendone/3
appendone(X, L1, [X|L1]).

% Definición de remove/3
remove(_, [], []).
remove(Item, [Item|Tail], NewList) :-
    remove(Item, Tail, NewList).
remove(Item, [Head|Tail], [Head|NewList]) :-
    Item \= Head,
    remove(Item, Tail, NewList).
