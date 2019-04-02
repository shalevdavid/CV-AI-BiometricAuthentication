%% Shape Representaion function
function [shapeRepresentation] = SortedShapeRepresentation(BW)

centroidSize = 10;

mask2(size(BW,1)+2*centroidSize,size(BW,2)+2*centroidSize) = 0;
mask2(centroidSize+1:size(BW,1)+centroidSize,centroidSize+1:size(BW,2)+centroidSize) = BW;

edgeMask2 = edge(mask2,'canny');

edgeMask2_rec = edgeMask2( centroidSize+1 :size(edgeMask2,1)-centroidSize  ,  centroidSize+1 :size(edgeMask2,2)-centroidSize );

meas = regionprops(BW,'centroid');

centBW = meas.Centroid;

% find all indexs of the edge;
[row2 col2] = find(edgeMask2_rec == 1);

% representaion1: compute distanceVector from center.
rowDiff2 = row2-centBW(2);
colDiff2 = col2-centBW(1);
distanceVector2 = sqrt(rowDiff2.^2 + colDiff2.^2);

theta = atan2(rowDiff2,colDiff2);
[shapeRepresentation.theta, sotredIndex] = sort(theta);
shapeRepresentation.r = distanceVector2(sotredIndex); % r is between 0 to 1.
        
