function [ means, covariances, priors ] = ComputeGMM( jointsData )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

quads = GenerateQuads(jointsData);

quadsFinal = reshape(quads, size(quads, 1) * size(quads, 2), 6);
quadsFinal = quadsFinal';

numClusters = 128;

[means, covariances, priors] = vl_gmm(quadsFinal, numClusters);

end

