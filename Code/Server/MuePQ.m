%% Get Shape Moments
function MUEpq = MuePQ(mask,p,q)
col = 1:size(mask,2);
row = 1:size(mask,1);
[COL,ROW] = meshgrid(col,row);

measurment = regionprops(mask, 'Centroid');
centroid = measurment.Centroid;

ColCent = centroid(1);
RowCent = centroid(2);

int = ((COL-ColCent).^p).*((ROW-RowCent).^q).*mask;
        
MUEpq = sum(int(:));

