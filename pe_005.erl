-module(pe_005).
-export([find_number/0, find_number/1, start/0]).

find_number() ->
	find_number(20).

find_number(Num) ->
	Test_list = lists:zip(lists:duplicate(20, Num), lists:seq(1, 20)),
	Bool = lists:all(fun({X, Y}) -> X rem Y == 0 end, Test_list),
	case Bool of
		true ->
			io:fwrite("~p~n", [Num]);
		false ->
			find_number(Num + 20)
	end.

start() ->
	find_number().
