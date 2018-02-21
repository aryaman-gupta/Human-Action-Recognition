    % The script assumes that the MSRAction3D dataset is stored in the parent
% folder of the working directory

cd ..
cd MSRAction3D\
cd MSRAction3DSkeleton(20joints)\
fileList = ls;
% Return to working directory
cd ..\..\Human-Action-Recognition\

% AS1 = [2 3 5 6 10 13 18 20]; % Action Set 1
AS1 = [2 3];
totalTrainData = zeros(4, 1000000);
startIndex = 1;

% Create GMM for all videos in Action Set
for i = 1:size(fileList, 1)
    k = fileList(i, 2:3); % Action number
    aNum = 10 * (int16(k(1))-48) + (int16(k(2))-48);
    if(ismember(aNum, AS1))
        fileList(i, :)
        [fileLength, temp] = readFile2(fileList(i, :));
        tempNan = isnan(temp);
        tempInf = isinf(temp);
        if(ismember(1, tempNan) || ismember(1, tempInf))
            fileList(i, :)
        end
        lastIndex = startIndex + fileLength - 1;
        totalTrainData(:, startIndex:lastIndex) = temp;
        startIndex = lastIndex + 1; 
    end
end
disp('Done reading files');
totalTrainData(:, startIndex:1000000) = [];

[means, covariances, priors] = ComputeGMM(totalTrainData);
disp('back in runscript');

% Generate FVs, train SVM using odd number actors
FV = zeros(300, 9216);
cnt = 1;
labels = zeros(1, 300);
for i = 1:size(fileList, 1)
    k = fileList(i, 2:3); % Action number
    aNum = 10 * int16(k(1)-48) + int16(k(2)-48);
    k2 = fileList(i, 6:7); % Subject number
    sNum = 10 * int16(k2(1)-48) + int16(k2(2)-48);
    if(ismember(aNum, AS1) && rem(sNum, 2) ~= 0 )
        fileList(i, :)
        FV(cnt, :) = ComputeFisherVector(fileList(i, :), means, covariances, priors);
        labels(cnt) = aNum;
        cnt = cnt + 1;        
    end
end

FV(cnt:300, :) = [];
labels(:, cnt:300) = [];

model = svmtrain(labels', FV, ''); % Using svmtrain from LIBSVM package

% Generate FVs, calculate accuracy for even actors
FVTest = zeros(300, 9216);
cnt = 1;
TestLabels = zeros(1, 300);
for i = 1:size(fileList, 1)
    k = fileList(i, 2:3); % Action number
    aNum = 10 * int16(k(1)-48) + int16(k(2)-48);
    k2 = fileList(i, 6:7); % Subject number
    sNum = 10 * int16(k2(1)-48) + int16(k2(2)-48);
    if(ismember(aNum, AS1) && rem(sNum, 2) == 0 )
        FVTest(cnt, :) = ComputeFisherVector(fileList(i, :), means, covariances, priors);
        TestLabels(cnt) = aNum;
        cnt = cnt + 1;        
    end
end

FVTest(cnt:300, :) = [];
TestLabels(:, cnt:300) = [];

[ predicted_label, accuracy, prob_estimates ] = ComputeAccuracy( FVTest, TestLabels', model );

disp(accuracy)