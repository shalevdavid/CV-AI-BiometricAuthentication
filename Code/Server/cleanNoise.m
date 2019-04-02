%% Clean Noise function
function cleanedMask = cleanNoise(mask)

% Remove noise by filling holes in background (closing backgroung).
% Assuming all ROI's of foregroung cross the borders of the image.
cleanedMask = 1 - imfill(1-mask,'holes');

% Leave only largest connectivity group - Assuming there is only one ROI (Region of Interest).
% Note: for multiple ROI's, could be done Cannonicaly/iteratively n times to leave n  largest connectivity groups ROI's.
maskProcessedNoise = cleanedMask;

CC = bwconncomp(maskProcessedNoise);
numPixels = cellfun(@numel,CC.PixelIdxList);
[biggest,idxTemp] = max(numPixels);
maskProcessedNoise(CC.PixelIdxList{idxTemp}) = 0;

cleanedMask = cleanedMask - maskProcessedNoise;

