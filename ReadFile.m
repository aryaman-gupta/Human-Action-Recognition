fileID = fopen('../MSRAction3D/MSRAction3DSkeletonReal3D/a01_s01_e01_skeleton3D.txt','r');
formatSpec = '%f %f %f %f';
sizeA = [4 Inf];
A1 = fscanf(fileID,formatSpec,sizeA);

fileID = fopen('../MSRAction3D/MSRAction3DSkeletonReal3D/a02_s01_e01_skeleton3D.txt','r');
formatSpec = '%f %f %f %f';
sizeA = [4 Inf];
A2 = fscanf(fileID,formatSpec,sizeA);

fileID = fopen('../MSRAction3D/MSRAction3DSkeletonReal3D/a01_s02_e01_skeleton3D.txt','r');
formatSpec = '%f %f %f %f';
sizeA = [4 Inf];
A3 = fscanf(fileID,formatSpec,sizeA);

fileID = fopen('../MSRAction3D/MSRAction3DSkeletonReal3D/a02_s02_e01_skeleton3D.txt','r');
formatSpec = '%f %f %f %f';
sizeA = [4 Inf];
A4 = fscanf(fileID,formatSpec,sizeA);

A = cat(2, A1, A2, A3, A4);

A = A';
l = size(A, 1);
B=reshape(A,20,l/20,4);


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

numClusters =128;

[means, covariances, priors] = vl_gmm(quadsFinal, numClusters);
