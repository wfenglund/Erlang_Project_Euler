-module(pe_014).
-export([start/0, collatz_generator/2, chain_checker/2]).

collatz_generator(1, Length) ->
	Length;

collatz_generator(Num, Length) ->
	case Num rem 2 == 0 of
		true ->
			collatz_generator(round(Num / 2), Length + 1);
		false ->
			collatz_generator((Num * 3) + 1, Length + 1)
	end.

chain_checker(0, Longest_chain) ->
	Longest_chain;

chain_checker(Cur_num, Longest_chain) ->
	Cur_length = collatz_generator(Cur_num, 1),
	case Cur_length > element(2, Longest_chain) of
		true ->
			chain_checker(Cur_num - 1, {Cur_num, Cur_length});
		false ->
			chain_checker(Cur_num - 1, Longest_chain)
	end.

start() ->
	{Num, Length} = chain_checker(1000000, {0, 0}),
	io:fwrite("Starting number: ~p~nSequence length: ~p~n", [Num, Length]).
