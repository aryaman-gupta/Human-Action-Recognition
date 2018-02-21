function [ quads ] = GenerateQuads( jointsData )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

jointsData = jointsData';
len = size(jointsData, 1);
B = reshape(jointsData,20,len/20,4);
global combs
tempQuad = zeros(4, 3);
quads = zeros(size(B, 2), size(combs, 1), 6);
for i = 1:size(B, 2)
    for j = 1:size(combs, 1)
        for k = 1:4
            for m = 1:3
                tempQuad(k, m) = B(combs(j, k), i, m);
            end
        end
        
        q1 = isnan(tempQuad);
        flag = 0;
        for l=1:size(q1, 1)
            for m = 1:size(q1, 2)
                if(q1(l, m) == 1)
                    flag = 1;
                end
            end
        end
        if(flag == 1)
            disp('nan found in tempQuad');
            j
            i
        end
        t = skeletalQuad(rearrangePoints(tempQuad)');
        q = isnan(t);
        flag = 0;
        for l=1:size(q, 1)
            for m = 1:size(q, 2)
                if(q(l, m) == 1)
                    flag = 1;
                end
            end
        end
        if(flag == 1)
            disp('nan found in skeletalRearrangement');
            j
            i
        end
        
        quads(i, j, 1:6) = t;%skeletalQuad(rearrangePoints(tempQuad)');
    end
end
%quads
end