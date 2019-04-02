%% CalcStatisticalParams
 function [stats] = CalcStatisticalParams(samples)
    stats.ave = mean(samples);
    stats.sigma = sqrt(var(samples,1));
    stats.min = min(samples);
    stats.max = max(samples);
    stats.maxDistFromAve = max( stats.max - stats.ave ,...
                                                         stats.ave - stats.min );
 
  