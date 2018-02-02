function [ combs ] = GenerateCombinations( )
%GenerateCombinations Generates all combinations of 20C4
%   Detailed explanation goes here

tempComp = [0 0 0 0];

combs = zeros(4845, 4);

cnt = 1;


for i=1:17
    tempComp(1) = i;
    for j=i+1:18
        tempComp(2) = j;
        for k=j+1:19
            tempComp(3) = k;
            for m=k+1:20
                tempComp(4) = m;
                for n=1:4
                    combs(cnt, n) = tempComp(n);
                end
                cnt = cnt+1;
            end
        end
    end
end

end

