function[y, x] = forwardelim_backsub(L, b)
%   Function that performs both forward elimination and back substitution
%   i.e. in forward elimination it solves for y in Ly = b and in back
%   substitution it solves for x in L^Tx = y

%   Author: Thomas Christinck, 2018.
    size_L = size(L);
    length = size_L(1);

    y(1:length)=0;
    for i = 1:length
        sum = 0;
        for j = 1:i
            sum = sum + (L(i, j) * y(j));
        end;
        y(i) = (b(i) - sum) / L(i, i);
    end;

    x(1:length, 1)=0;
    for i = length:-1:1
        sum = 0;
        for j = i:length
            sum = sum + (L(j, i) * x(j));
        end;
        x(i) = (y(i) - sum) / L(i,i);
    end;
