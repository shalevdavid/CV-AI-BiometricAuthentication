%% Extracting Edges After Expansion(maskTemp)
function edgeMask2_rec = ExtractEdgeAfterExpansion(maskTemp)
% Extracting edges of a maskTemp (including the borders)
% done by expanding the image beforehand and Shrinking after.    
sizeCurImage = size(maskTemp);
centroidSize = 10;

mask2(sizeCurImage(1)+2*centroidSize,sizeCurImage(2)+2*centroidSize) = 0;
mask2(centroidSize+1:sizeCurImage(1)+centroidSize,centroidSize+1:sizeCurImage(2)+centroidSize) = maskTemp;
edgeMask2 = edge(mask2,'canny');
edgeMask2_rec = edgeMask2( centroidSize+1 :size(edgeMask2,1)-centroidSize  ,  centroidSize+1 :size(edgeMask2,2)-centroidSize );

