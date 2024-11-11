formula( and(X, Y)):-
    formula(X),
    formula(Y).


enCarro(cdmx,edomex).
enCarro(edomex,morelia).
enCarro(pachuca,guanajuato).
enCarro(pachuca,tlaxcala).

enAvion(oaxaca,nuevoleon).
enAvion(guanajuato,nuevoleon).
enAvion(oaxaca,merida).
enAvion(nuevoleon,merida).

enTren(edomex,tabasco).
enTren(edomex,aguascalientes).
enTren(merida,chiapas).
enTren(veracruz,cdmx).
enTren(chiapas,cdmx).

conexion( X, Y):-
    enCarro(X, Y);
    enAvion(X, Y);
    enTren(X,Y).
conexion(X, Y):-
    enCarro(X, Z), conexion(Z, Y);
    enAvion(X, Z), conexion(Z, Y);
    enTren(X, Z), conexion(Z, Y).
