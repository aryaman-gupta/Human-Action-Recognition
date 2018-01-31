function [ arrangedPoints ] = rearrangePoints( points )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
dist = distPoints(points(1, 1:3), points(2, 1:3));
max = dist;
index = [1, 2, 3, 4];
dist = distPoints(points(1, 1:3), points(3, 1:3));
if dist > max
    max = dist;
    index = [1, 3, 2, 4];
end
dist = distPoints(points(1, 1:3), points(4, 1:3));
if dist > max
    max = dist;
    index = [1, 4, 2, 3];
end
dist = distPoints(points(2, 1:3), points(3, 1:3));
if dist > max
    max = dist;
    index = [2, 3, 1, 4];
end
dist = distPoints(points(2, 1:3), points(4, 1:3));
if dist > max
    max = dist;
    index = [2, 4, 1, 3];
end
dist = distPoints(points(3, 1:3), points(4, 1:3));
if dist > max
    index = [3, 4, 1, 2];
end

arrangedPoints(1, 1:3) = points(index(1), 1:3);
arrangedPoints(2, 1:3) = points(index(2), 1:3);
arrangedPoints(3, 1:3) = points(index(3), 1:3);
arrangedPoints(4, 1:3) = points(index(4), 1:3);
end

