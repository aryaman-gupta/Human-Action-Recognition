function [ means, covariances, priors ] = ComputeGMM( jointsData )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

jointsData = jointsData';
l = size(jointsData, 1);
B = reshape(jointsData,20,l/20,4);


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

quadsFinal = reshape(quads, size(quads, 1) * size(quads, 2), 6);
quadsFinal = quadsFinal';

numClusters = 128;

[means, covariances, priors] = vl_gmm(quadsFinal, numClusters);

end

