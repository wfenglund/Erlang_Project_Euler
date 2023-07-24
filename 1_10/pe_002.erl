-module(pe_002).
-export([get_numbers/4, start/0]).

get_numbers(Max, Current, Previous, In_sum) ->
	New = Current + Previous,
	case New < Max of
		true ->
			case New rem 2 == 0 of
				true ->
					Out_sum = New + In_sum;
				false ->
					Out_sum = In_sum
			end,
			get_numbers(Max, New, Current, Out_sum);
		false ->
			io:fwrite("~p~n", [In_sum])
	end.

start() ->
	get_numbers(4000000, 1, 0, 0).
