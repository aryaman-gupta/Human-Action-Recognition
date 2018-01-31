function [ dist ] = distPoints( point1, point2 )
%Calculates distance between two 3D points

dist = (point1(1) - point2(1))*(point1(1) - point2(1));
dist = dist + (point1(2) - point2(2))*(point1(2) - point2(2));
dist = dist + (point1(3) - point2(3))*(point1(3) - point2(3));
dist = sqrt(dist);
end

