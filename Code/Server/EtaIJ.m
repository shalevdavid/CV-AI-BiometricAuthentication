%% Get Shape Moments
function ETAij = EtaIJ(mask,i,j)
ETAij = MuePQ(mask,i,j)/(MuePQ(mask,0,0)^(1+(i+j)/2));
    
