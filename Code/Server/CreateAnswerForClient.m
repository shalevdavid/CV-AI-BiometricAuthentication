function CreateAnswerForClient(createAnsForClientDir, id, inputImageFileName, outputImageName)
%% make new folder
if (~exist(createAnsForClientDir,'dir'))
    mkdir(createAnsForClientDir);
end;
% if (exist(createAnsForClientDir,'dir'))
%     rmdir(createAnsForClientDir,'s');
% end;
% mkdir(createAnsForClientDir);

%% Genarate new Image (attached id to input image)
inputImg = im2double(imread(inputImageFileName));
outputImage = GenerateImageWithId(inputImg, id, [0 0 1]);

%% Save picture
imwrite(outputImage, outputImageName);