-module(pruebas).
-export([start/0]).

start() ->
	serv:start(archivo1),
	cliente:login(manuel, archivo1),
	cliente:login(juan, archivo1),
	io:format("Creacion del servidor y usuarios ok~n"),
	cliente:open(juan),
	cliente:open(manuel),
	cliente:who(manuel),
	cliente:close(juan),
	cliente:who(manuel),
	cliente:open(manuel),
	cliente:who(juan),
	cliente:close(juan),
	cliente:who(juan),
	cliente:close(manuel).