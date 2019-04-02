%% CalcStatisticalParams
 function [stats] = CalcStatisticalParams2(samples)
    stats.ave = mean(samples);
    stats.sigma = sqrt(var(samples,1));
    stats.min = min(samples);
    stats.max = max(samples);
    stats.maxDistFromAve = max( stats.max - stats.ave ,...
                                                         stats.ave - stats.min );
                                                     
    
    stats.ave = DataHash(floor(stats.ave*10^3));    % Saving hash value of floor value since floating point of matlab is not accurate.
	stats.sigma = floor(stats.sigma*10^3);
 
  