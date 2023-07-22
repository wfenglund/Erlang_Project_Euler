-module(pe_010).
-export([supervisor/3, prime_checker/2, prime_finder/4, worker_launcher/4, start/0]).

list_maker(Start, Stop, Step, Out) when Start + Step >= Stop ->
	lists:sort([Start, Stop] ++ Out);

list_maker(Start, Stop, Step, Out) ->
	list_maker(Start + Step + 1, Stop, Step, [Start, Start + Step] ++ Out).

supervisor(Package, Counter, Pid) ->
	case Counter < 1 of
		true ->
			Pid ! {allPrimes, Package};
		false ->
			receive
				{part, Prime_sum} ->
					supervisor(Prime_sum + Package, Counter - 1, Pid);
				_ ->
					supervisor(Package, Counter, Pid)
			end
	end.

prime_checker(Num, Num) ->
	true;

prime_checker(Num, Div) ->
	case Num rem Div == 0 of  
		true ->
			false;
		false ->
			prime_checker(Num, Div + 1)
	end.

prime_finder(Prime_sum, Num, Stop, Pid) when Num > Stop ->
	Pid ! {part, Prime_sum};

prime_finder(Prime_sum, Num, Stop, Pid) ->
	Bool = prime_checker(Num, 2),
	case Bool of
		false ->
			prime_finder(Prime_sum, Num + 1, Stop, Pid);
		true ->
			prime_finder(Num + Prime_sum, Num + 1, Stop, Pid)
	end.

worker_launcher(_, _, [], _) ->
	ok;

worker_launcher(Module, Func, [Start|[Stop|Tasks]], Pid) ->
	spawn(Module, Func, [0, Start, Stop, Pid]),
	worker_launcher(Module, Func, Tasks, Pid).

start() ->
	Tasks = list_maker(2, 2000000, 10000, []),
	Pid = spawn(pe_010, supervisor, [0, length(Tasks)/2, self()]),
	worker_launcher(pe_010, prime_finder, Tasks, Pid),
	receive
		{allPrimes, Results} ->
			workDone
	end,
	io:fwrite("~p~n", [Results]).
