%% Get Shape Moments
function Mpq = MomentPQ(mask,p,q)
col = 1:size(mask,2);
row = 1:size(mask,1);
[COL,ROW] = meshgrid(col,row);

int = (COL.^p).*(ROW.^q).*mask;
        
Mpq = sum(int(:));

