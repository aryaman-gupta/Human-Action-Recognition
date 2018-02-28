function [ predicted_label, accuracy, prob_estimates ] = ComputeAccuracy( TestFV, testLabels, model )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

[predicted_label, accuracy, prob_estimates] = svmpredict(testLabels, TestFV, model);

end

