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

viaje(A, B) :- enCarro(A, B).
viaje(A, B) :- enAvion(A, B).
viaje(A, B) :- enTren(A, B).
viaje(A, B) :- enCarro(A, X), viaje(X, B).
viaje(A, B) :- enAvion(A, X), viaje(X, B).
viaje(A, B) :- enTren(A, X), viaje(X, B).

ruta(A, B, [A,B]) :- viaje(A, B).
ruta(A, B, [A|R]) :- (enCarro(A, C) ; enAvion(A, C) ; enTren(A, C)), ruta(C, B, R).
