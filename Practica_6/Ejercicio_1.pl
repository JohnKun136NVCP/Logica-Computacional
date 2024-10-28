appendtail(L1, L2, L3) :-
    append(L2, L1, L3).
appendone(X, L1, [X|L1]).
