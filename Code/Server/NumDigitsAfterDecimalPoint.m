function y = NumDigitsAfterDecimalPoint(x)

x = abs(x); %in case of negative numbers
y = 0;

while (mod(x*10^y,1)~=0)
    y = y+1;
end
