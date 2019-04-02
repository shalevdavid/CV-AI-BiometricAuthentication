 function mark = GetMark2(val, stats)         
     
     mark = 0;
     val = floor(val*10^3);
     
     hashAve = stats.ave;
     
     for i=-3*(stats.sigma+1):3*(stats.sigma+1)
         curHash=DataHash(val+i);
         if ( curHash == hashAve )
             mark = 100;
             break;
         end;
     end;