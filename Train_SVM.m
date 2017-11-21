function [ model ] = Train_SVM( FV, labels )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

for i = 1:size(FV, 3)
    trainData(6*i - 5:6*i, :) = FV(:, :, i);
end


for i = 1:size(FV, 3)
    for j = 1:size(FV, 1)
        model = svmtrain(labels, trainData, '-c 1 -g 0.07 -b 1');
    end
end


end

