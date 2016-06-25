:- dynamic location/1, performance/1.
:- assert(performance(0)), assert(location(0)).

clean:-
	location(X),
	retract(location(X)),
	write('The tile number '),
	write(X),
	write(' is dirty.'),
	nl,
	performance(Y),
	retract(performance(Y)),
	write('Cleaning tile number '),
	write(X),
	nl,
	X_new is X+1,
	writeln('Moving to the next tile'),
	writeln('.............................'),
	Y_new is Y+2,
	assert(performance(Y_new)),
	assert(location(X_new)).

pass:-
	location(X),
	retract(location(X)),
	write('The tile number '),
	write(X),
	write(' is clean.'),
	nl,
	writeln('Moving to the next tile'),
	writeln('.............................'),
	performance(Y),
	retract(performance(Y)),
	X_new is X+1,
	Y_new is Y+1,
	assert(performance(Y_new)),
	assert(location(X_new)).

check_dirty(X):-
	X = '1' *-> clean; pass.

finish:-
	performance(Y),
	write('The performance measure is: '),
	write(Y),
	nl,
	writeln('Finished!').

power_on([]):-
	finish,
	!.

power_on([H|T]):-
	check_dirty(H),
	power_on(T).

go:-
	writeln('Please enter clean dirty sequence of 1 dimentional room'),
	writeln('seperated by number of tiles of your choice'),
	writeln('1 being dirty and 0 being clean in one string'),
	writeln('(Every action costs 1 point e.g. cleaning, moving)'),
	nl,
	read(X),
	string_chars(X,Y),
	power_on(Y).
