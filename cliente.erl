-module(cliente).
-export([open/1, close/1, who/1, login/2]).

login(Nombre, Archivo) ->
	register(Nombre, spawn(fun()-> cliente([{Nombre, Archivo}]) end)),
	io:format("Usuario conectado ~n").

cliente([{Nombre, Archivo}]) ->
	receive
		open ->
		Archivo ! {open, Nombre},
		cliente([{Nombre,Archivo}]);
		close ->
		Archivo ! {close},
		cliente([{Nombre,Archivo}]);
		who ->
		Archivo ! {who},
		cliente([{Nombre,Archivo}])
	end.

open(Cliente) ->
Cliente ! open.

close(Cliente) ->
Cliente ! close.

who(Cliente) ->
Cliente ! who.
