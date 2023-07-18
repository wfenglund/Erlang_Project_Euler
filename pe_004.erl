-module(pe_004).
-export([check_pallindrome/3, start/0]).

check_pallindrome(99, _, In_res) ->
	lists:last(lists:sort(In_res));

check_pallindrome(X, 99, In_res) ->
	check_pallindrome(X - 1, 999, In_res);

check_pallindrome(X, Y, In_res) ->
	Z = X * Y,
	Bool = integer_to_list(Z) == lists:reverse(integer_to_list(Z)),
	case Bool of
		true ->
			Out_res = [Z] ++ In_res;
		false ->
			Out_res = In_res
	end,
	check_pallindrome(X, Y - 1, Out_res).

start() ->
	Result = check_pallindrome(999, 999, []),
	io:fwrite("~p~n", [Result]).

