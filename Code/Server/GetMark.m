%% GetMark of new observation
 function mark = GetMark(val, stats)
	if ( abs(val - stats.ave)<=(3*stats.sigma) )
        mark = 100;
    else
        mark = 0;
	end;

   