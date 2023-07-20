-module(pe_007).
-export([prime_finder/2, start/0]).

% Note: this is a suboptimal solution since it takes more
% than 1 minute to run, but it works

prime_finder(10001, Num) ->
	io:fwrite("~p~n", [Num - 1]);

prime_finder(Primes, Num) ->
	Test_list = lists:zip(lists:duplicate(Num -2, Num), lists:seq(2, Num - 1)),
	Bool = lists:any(fun({X, Y}) -> X rem Y == 0 end, Test_list),
	case Bool of
		true ->
			prime_finder(Primes, Num + 1);
		false ->
			prime_finder(Primes + 1, Num + 1)
	end.

start() ->
	prime_finder(0, 2).
