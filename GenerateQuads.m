function [ quads ] = GenerateQuads( jointsData )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
jointsData = jointsData';
l = size(jointsData, 1);
B = reshape(jointsData,20,l/20,4);
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
        quads(i, j, 1:6) = skeletalQuad(rearrangePoints(tempQuad)');
    end
end

end

