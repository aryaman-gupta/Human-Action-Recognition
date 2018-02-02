% % The script assumes that the MSRAction3D dataset is stored in the parent
% % folder of the working directory
% cd ..
% cd MSRAction3D\
% cd MSRAction3DSkeleton(20joints)\
% fileList = ls;
% % Return to working directory
% cd ..\..\Human-Action-Recognition\
% 
% 
% totalTrainData = readFile2(fileList(4, :));
% A2 = readFile2(fileList(3, :));
% totalTrainData = [totalTrainData, A2];
% 
% combs = GenerateCombinations(); % The combinations that will be used
%                                 % to generate quads
% 
% [means, covariances, priors] = ComputeGMM(totalTrainData);
% 
% FV(1, :) = ComputeFisherVector(fileList(5, :), means, covariances, priors);
% FV(2, :) = ComputeFisherVector(fileList(6, :), means, covariances, priors);
% labels = [1 2]';
% model = svmtrain(labels, FV, ''); % Using svmtrain from LIBSVM package
global combs 
combs = GenerateCombinations();
FVTest(1, :) = ComputeFisherVector(fileList(7, :), means, covariances, priors);
FVTest(2, :) = ComputeFisherVector(fileList(8, :), means, covariances, priors);
TestLabels = [1 2]';
[ predicted_label, accuracy, prob_estimates ] = ComputeAccuracy( FVTest, TestLabels, model );
accuracy
