% The script assumes that the MSRAction3D dataset is stored in the parent
% folder of the working directory
cd ..
cd MSRAction3D\
cd MSRAction3DSkeleton(20joints)\
fileList = ls;
% Return to working directory
cd ..\..\Human-Action-Recognition\


totalFileData = readFile2(fileList(4, :));
A2 = readFile2(fileList(3, :));
totalFileData = [totalFileData, A2];

[means, covariances, priors] = ComputeGMM(totalFileData);



% for i = 4:size(fileList, 1)
%     
% end

