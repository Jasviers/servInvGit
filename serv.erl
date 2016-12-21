-module(serv).
-export([start/1]).

start(NombreArchivo)->
	register(NombreArchivo, spawn(fun()-> serv([{NombreArchivo, 0, 'Sin uso'}]) end)).

serv([{NombreArchivo, State, Cliente}])->
	receive
		
		{open, PID} ->
			case State of
				0 -> serv([{NombreArchivo, 1, PID}]);
				1 -> io:format("El archivo ya esta en uso~n"),
					 serv([{NombreArchivo,State,Cliente}])
			end;

		
		{close} ->
			case State of
				1 -> serv([{NombreArchivo, 0, 'Sin uso'}]);
				0 -> io:format("El archivo ya esta en uso~n"),
					 serv([{NombreArchivo,State,Cliente}])
			end;
		
		{who} ->
			io:format("Usuario que esta usando el archivo: ~w~n",[Cliente]),
			serv([{NombreArchivo, State, Cliente}])
	end.
