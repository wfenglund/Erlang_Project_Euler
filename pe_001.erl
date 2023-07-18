-module(pe_001).
-export([get_numbers/2, start/0]).

get_numbers([], In_num) ->
	In_num;

get_numbers([H|T], In_num) ->
	case H rem 3 == 0 orelse H rem 5 == 0 of
	true ->
			Out_num = H + In_num;
	false ->
			Out_num = In_num
	end,
	get_numbers(T, Out_num).

start() ->
	Results = get_numbers(lists:seq(1, 999), 0),
	io:fwrite("~p~n", [Results]).
