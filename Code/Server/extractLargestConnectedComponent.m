%%  extract Largest Connected Component function
function maskPost = extractLargestConnectedComponent(maskPre)
maskPost = maskPre;

CC = bwconncomp(maskPre);
numPixels = cellfun(@numel,CC.PixelIdxList);
[biggest,idxTemp] = max(numPixels);
maskPre(CC.PixelIdxList{idxTemp}) = 0;

maskPost = maskPost - maskPre;

