-module(pe_006).
-export([sum_squarer/0, sum_squarer/1, start/0]).

sum_squarer() ->
	sum_squarer(lists:foldl(fun(X, Y) -> X + Y end, 0, lists:seq(1, 100))).

sum_squarer(Sum) ->
	Sum * Sum.

start() ->
	Sum_square = sum_squarer(),
	Square_sum = lists:foldl(fun(X, Y) -> (X*X) + Y end, 0, lists:seq(1, 100)),
	io:fwrite("~p~n", [Sum_square - Square_sum]).
