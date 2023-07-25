-module(pe_012).
-export([triangle_generator/2, split_list/3, supervisor/1, factor_finder/3, worker/2, worker_launcher/2, start/0]).

triangle_generator([H|T], _) when H > 100000000 ->
	lists:reverse([H|T]);

triangle_generator([H|T], Counter) ->
	triangle_generator([Counter + H] ++ [H|T], Counter + 1).

split_list([], _, Out_list) ->
	lists:reverse(Out_list);

split_list(In_list, Size, Out_list) when Size > length(In_list) ->
	lists:reverse([In_list|Out_list]);

split_list(In_list, Size, Out_list) ->
	{H, T} = lists:split(Size, In_list),
	split_list(T, Size, [H|Out_list]).

supervisor(PID) ->
	receive
		{factor, Num, Factors} when Factors > 500 ->
			PID ! {finalFactor, Num, Factors}
	end,
	supervisor(PID).

factor_finder(_, 0, Factors) ->
	Factors;

factor_finder(Num, Test, Factors) when Test + Num rem 2 == 0 ->
	case Num rem Test == 0 of
		true ->
			factor_finder(Num, round(Test / 2), Factors + 1);
		false ->
			factor_finder(Num, Test - 1, Factors)
	end;

factor_finder(Num, Test, Factors) ->
	case Num rem Test == 0 of
		true ->
			factor_finder(Num, Test - 1, Factors + 1);
		false ->
			factor_finder(Num, Test - 1, Factors)
	end.

worker([], _) ->
	jobDone;

worker([H|T], PID) ->
	PID ! {factor, H, factor_finder(H, H, 0)},
	worker(T, PID).

worker_launcher([], _) ->
	ok;

worker_launcher([H|T], PID) ->
	spawn(pe_012, worker, [H, PID]),
	worker_launcher(T, PID).

start() ->
	Tasks = triangle_generator([0], 0),
	Task_list = split_list(Tasks, 4000, []),
	PID = spawn(pe_012, supervisor, [self()]),
	worker_launcher(Task_list, PID),

	receive
		{finalFactor, Num, Factors} ->
			io:fwrite("~p : ~p~n", [Num, Factors])
	end.
