remove(_, [], []).
remove(Item, [Item|Tail], NewList) :-
    remove(Item, Tail, NewList).
remove(Item, [Head|Tail], [Head|NewList]) :-
    Item \= Head,
    remove(Item, Tail, NewList).
