-module(pe_009).
-export([find_triplets/3, start/0]).

find_triplets(A, B, C) when B >= C ->
	find_triplets(A + 1, A + 2, 1000 - ((A*2) + 3));

find_triplets(A, B, C) when (A < B) and (B < C) ->
	case (A*A + B*B) == C*C of
		true ->
			io:fwrite("~p*~p*~p = ~p~n", [A, B, C, A*B*C]);
		false ->
			find_triplets(A, B + 1, C - 1)
	end.

start() ->
	find_triplets(0, 0, 0).
