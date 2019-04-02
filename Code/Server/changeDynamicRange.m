%%  changeDynamicRange function
function outputImage = changeDynamicRange(inputImage,minVal,maxVal)

fmin = min(inputImage(:));
fmax = max(inputImage(:));

outputImage = (inputImage - fmin)/(fmax-fmin);

outputImage = (maxVal-minVal)*outputImage + minVal;

