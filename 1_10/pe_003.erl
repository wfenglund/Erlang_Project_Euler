-module(pe_003).
-export([check_numbers/2, start/0]).

check_numbers(1, Last_fac) ->
	io:fwrite("~p~n", [Last_fac]); % Print the most recent factor

check_numbers(Last_num, Last_fac) ->
	case Last_num rem Last_fac == 0 of
		true ->
			New_fac = Last_fac,
			New_num = round(Last_num / Last_fac);
		false ->
			New_fac = Last_fac + 1,
			New_num = Last_num
	end,
	check_numbers(New_num, New_fac).

start() ->
	check_numbers(600851475143, 2).
