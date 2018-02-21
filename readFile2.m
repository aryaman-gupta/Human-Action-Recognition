function [ fileLength, fileData ] = readFile2( fileName )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
cd ..
cd MSRAction3D\
cd MSRAction3DSkeleton(20joints)\
[fileID, m] = fopen(fileName,'r');
if(fileID == -1)
    disp(m);
end
formatSpec = '%f %f %f %f';
sizeA = [4 Inf];
fileData = fscanf(fileID,formatSpec,sizeA);
fileLength = size(fileData, 2);
% Return to working directory
cd ..\..\Human-Action-Recognition\
end

