function [ fileData ] = readFile2( fileName )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
cd ..
cd MSRAction3D\
cd MSRAction3DSkeleton(20joints)\
fileID = fopen(fileName,'r');
formatSpec = '%f %f %f %f';
sizeA = [4 Inf];
fileData = fscanf(fileID,formatSpec,sizeA);
% Return to working directory
cd ..\..\Human-Action-Recognition\
end

