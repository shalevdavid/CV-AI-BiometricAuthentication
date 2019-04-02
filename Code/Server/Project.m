%Project('D:\shalev\Projects\WorkspaceEclipseMars2\videoCameraCaptureFrames\temp\inputImage.jpg','D:\shalev\Projects\WorkspaceEclipseMars2\videoCameraCaptureFrames\temp\outputImage.jpg','')
function Project(input_img_path, output_img_path, DBtype, id)
%-----------------------------------------------------------------------------
% IDC Hertzliya
% Author: Shalev David
%------------------------------------------------------------------------------
% INPUT:
% input_img_path - input image path
% output_img_path - output image path
%------------------------------------------------------------------------------
tic;
%Add VLFeat library for computing SIFT feature
% addpath(genpath('./vlfeat-0.9.20/'))

% extLibs = 'D:\shalev\Projects\WorkspaceMatlab\ExternalLibs';
% addpath(genpath(extLibs));
withFigures = 'NoFigures';

if nargin < 2
    input_img_path =('./upload/test.jpg');
    output_img_path =('./output/test.jpg');
end

if(isempty(input_img_path))
    input_img_path =('./upload/test.jpg');
end
    
if(isempty(output_img_path))
    output_img_path =('./output/test.jpg');
end

InputImg = imread(input_img_path) ;

% DBtype = 'openedHand';

Results = MainScript(InputImg, DBtype, withFigures, id);
% Results = Main(InputImg, 'NO_FIGURES');

validPic = imread('Valid.jpg');
invalidImage = imread('notValid.jpg');

if (Results.valid==1)
    OutputImg = validPic;
else
    OutputImg = invalidImage;
end    
    
outI = OutputImg;
outI = imresize(outI, [size(InputImg,1) size(InputImg,2)]);
imwrite(outI, output_img_path,'Quality',100);

toc
end
