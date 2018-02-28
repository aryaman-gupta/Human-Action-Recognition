% The script assumes that the MSRAction3D dataset is stored in the parent
% folder of the working directory
global combs;
cd ..
cd MSRAction3D\
cd MSRAction3DSkeleton(20joints)\
fileList = ls;
% Return to working directory
cd ..\..\Human-Action-Recognition\
% 
AS1 = [2 3 5 6 10 13 18 20]; % Action Set 1
% AS1 = [2 5 10 20];
% AS1 = [2];
if(fopen('GMM Params.mat') == -1)
    disp('Generating GMM');
    totalTrainData = zeros(4, 1000000);
    startIndex = 1;

    % Create GMM for all videos in Action Set
    for i = 1:size(fileList, 1)
        k = fileList(i, 2:3); % Action number
        aNum = 10 * (int16(k(1))-48) + (int16(k(2))-48);
        if(ismember(aNum, AS1))
    %         fileList(i, :)
            [fileLength, temp] = readFile2(fileList(i, :));
    %         tempNan = isnan(temp);
    %         tempInf = isinf(temp);
    %         if(ismember(1, tempNan) || ismember(1, tempInf))
    %             fileList(i, :)
    %         end
            lastIndex = startIndex + fileLength - 1;
            totalTrainData(:, startIndex:lastIndex) = temp;
            startIndex = lastIndex + 1; 
        end
    end
    disp('Done reading files');
    totalTrainData(:, startIndex:1000000) = [];

    quadsFinal = ComputeGMM(totalTrainData);
    disp('back in runscript');
    numClusters = 128;
    clear totalTrainData;
    [means, covariances, priors] = vl_gmm(quadsFinal, numClusters);
    clear quadsFinal;
    disp('done generating gmm');
    save('GMM Params', 'means', 'covariances', 'priors');
else
    load('GMM Params');
    combs = GenerateCombinations();
end
if(fopen('FisherVelctors.mat') == -1)
    disp('Generating FVs');
    % Generate FVs using odd number actors
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
    
    % Generate FVs for testing, from even actors
    FVTest = zeros(300, 9216);
    cnt = 1;
    TestLabels = zeros(1, 300);
    for i = 1:size(fileList, 1)
        k = fileList(i, 2:3); % Action number
        aNum = 10 * int16(k(1)-48) + int16(k(2)-48);
        k2 = fileList(i, 6:7); % Subject number
        sNum = 10 * int16(k2(1)-48) + int16(k2(2)-48);
        if(ismember(aNum, AS1) && rem(sNum, 2) == 0 )
            fileList(i, :)
            FVTest(cnt, :) = ComputeFisherVector(fileList(i, :), means, covariances, priors);
            TestLabels(cnt) = aNum;
            cnt = cnt + 1;        
        end
    end

    FVTest(cnt:300, :) = [];
    TestLabels(:, cnt:300) = [];
    save('FisherVectors', 'FV', 'FVTest', 'labels', 'TestLabels');
else
    load('FisherVectors');    
end
probTable = zeros(size(AS1, 2), size(FVTest, 1));
for i = 1:size(AS1, 2)
    curClass = AS1(1, i);
    trainLab = 2 * (labels == curClass) - 1;
    model = svmtrain(trainLab', FV, '-t 0 -s 0 -h 0 -c 100'); % Using svmtrain from LIBSVM package
    w = model.SVs' * model.sv_coef;
    for j = 1:size(FVTest, 1)
        probTable(i, j) = w' * FVTest(j, :)' - model.rho;
    end
end

[m, ind] = max(probTable);
correctInd = (AS1(ind)==TestLabels);
numCor = sum(correctInd(:) == 1);
accuracy = numCor / size(FVTest, 1);
disp(accuracy * 100)