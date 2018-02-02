function [ fisherFinal ] = ComputeFisherVector( fileName, means, covariances, priors )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

jointsData = readFile2(fileName);

quads = GenerateQuads(jointsData);

quadsFinal = reshape(quads, size(quads, 1) * size(quads, 2), 6);
quadsFinal = quadsFinal';

length = size(quadsFinal, 1);

fisherEncoding(1, :) = vl_fisher(quadsFinal(1:6, 1:length/3), means, covariances, priors, 'improved');
fisherEncoding(2, :) = vl_fisher(quadsFinal(1:6, length/3+1:2*length/3), means, covariances, priors, 'improved');
fisherEncoding(3, :) = vl_fisher(quadsFinal(1:6, 2*length/3+1:length), means, covariances, priors, 'improved');

fisherEncoding(4, :) = vl_fisher(quadsFinal(1:6, 1:length/2), means, covariances, priors, 'improved');
fisherEncoding(5, :) = vl_fisher(quadsFinal(1:6, length/2+1:length), means, covariances, priors, 'improved');

fisherEncoding(6, :) = vl_fisher(quadsFinal(1:6, 1:length), means, covariances, priors, 'improved');

fisherFinal = [fisherEncoding(1, :), fisherEncoding(2, :), fisherEncoding(3, :), fisherEncoding(4, :), fisherEncoding(5, :), fisherEncoding(6, :)];

for j = 1:size(fisherFinal, 2)
    fisherFinal(1, j) = sign(fisherFinal(1, j)) * (abs(fisherFinal(1, j)) ^ 0.3);
end

end

