%% Maximum Correlation - The function assumes non-normalized inputs x1,x2.
function maxCorr = MaxCorr(x1,x2)

x1 = x1/sqrt(sum(x1.^2));
x2 = x2/sqrt(sum(x2.^2)); 
 
fftCalc = ifft(abs(fft(x1).*(fft(x2))));
maxCorr = fftCalc(1);

