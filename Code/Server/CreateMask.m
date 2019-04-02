%% CreateMask function - 2Means and EdgeDetection Based.
function maskProcessed = CreateMask(input_img, withFigures,type)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%                                      %%%%%%%%%%%%
%%%%%%%%%%%%%       Extract Images     %%%%%%%%%%%%
%%%%%%%%%%%%%                                      %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

R = input_img(:,:,1);
G = input_img(:,:,2);
B = input_img(:,:,3);

YCbCr = rgb2ycbcr(input_img);
Y = YCbCr(:,:,1);
Cb = YCbCr(:,:,2);
Cr = YCbCr(:,:,3);

HSV = rgb2hsv(input_img);
H = HSV(:,:,1);
S = HSV(:,:,2);
V = HSV(:,:,3);

doubleR = double(R)/255;
doubleG = double(G)/255;
doubleB = double(B)/255;
doubleY = double(Y)/255;
doubleCb = double(Cb)/255;
doubleCr = double(Cr)/255;
doubleH = double(H);
doubleS = double(S);
doubleV = double(V);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%                           %%%%%%%%%%%%
%%%%%%%%%%          Otsu         %%%%%%%%%%%%
%%%%%%%%%%                           %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (strcmp(type,'Otsu'))
    preProcessFlag = 0;
    if (preProcessFlag == 1)
        input_img_for_otsuSegmentation = PreProcessing(R/3+G/3+B/3,'MEDIAN','GAUSSIAN','NO_SHARP',0); % can be good ig SNR-in is OK for all channels.
    else
        input_img_for_otsuSegmentation = input_img;
    end
    
    level = graythresh(input_img_for_otsuSegmentation);
    maskProcessed = double(im2bw(input_img_for_otsuSegmentation,level));
    
    sizeCurImage = size(maskProcessed);
    % choose mask:
    numOfConrensInCluster =  maskProcessed(1,1) +  maskProcessed(sizeCurImage(1),1) +  maskProcessed(1,sizeCurImage(2)) + maskProcessed(sizeCurImage(1),sizeCurImage(2));
    if (numOfConrensInCluster>=3)
        maskProcessed = 1- maskProcessed;
    end;    
    
    maskProcessed = cleanNoise(maskProcessed);
    maskProcessed = imfill(maskProcessed, 'holes');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%                                      %%%%%%%%%%%%
%%%%%%%%%%%%%          K-MEANS          %%%%%%%%%%%%
%%%%%%%%%%%%%                                      %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (strcmp(type,'ownUsingKmeans'))

K=2;
curImage = doubleCr;

% ','Replicates',5 - to avoid local-minima.
opts = statset('Display','final');
[IDX,C] = KMEANS(curImage(:),K,'start','uniform', 'emptyaction','singleton','Replicates',5,'Options',opts);

sizeCurImage = size(curImage);
idx = reshape(IDX,[sizeCurImage(1),sizeCurImage(2)]);

%% Extract binary clusters:

numOfClusters = K;

for clusterIndex = 1:numOfClusters
	idx_cluster(:,:,clusterIndex) = (double(idx == clusterIndex));
    if ( strcmp(withFigures,'WITH_FIGURES') )
        figure, imshow(idx_cluster(:,:,clusterIndex));
    end
end;

%% find Centroids:

for clusterIndex = 1:numOfClusters
    measurements = regionprops(double(idx == clusterIndex), 'Centroid');
    cent(1,clusterIndex) = measurements.Centroid(2);
    cent(2,clusterIndex) = measurements.Centroid(1);
end;

% Display all clusters in one image - Red coloured
disp(:,:,1) = idx*255/numOfClusters;
disp(:,:,2) = 0;
disp(:,:,3) = 0;

if ( strcmp(withFigures,'WITH_FIGURES') )
    figure, imshow(uint8(disp))
end

%% Draw Centroids:

% Notice that image is increased by centroidSize for the
% case of centerMass being in the borders of the image.

centroidSize = 10; %Coter

for clusterIndex = 1:numOfClusters

	disp(:,:,1) = double(idx == clusterIndex)*255;
	disp(:,:,2) = 0;
	disp(:,:,3) = 0;

	disp2(sizeCurImage(1)+2*centroidSize,sizeCurImage(2)+2*centroidSize,3) = 0;
	disp2(centroidSize+1:sizeCurImage(1)+centroidSize,centroidSize+1:sizeCurImage(2)+centroidSize,:) = disp;

	%% Centroid color chosen to be Green.
	disp2( round(cent(1,clusterIndex)) :round(cent(1,clusterIndex))+2*centroidSize ,  round(cent(2,clusterIndex)):round(cent(2,clusterIndex))+2*centroidSize ,1) = 0;
	disp2( round(cent(1,clusterIndex)) :round(cent(1,clusterIndex))+2*centroidSize ,  round(cent(2,clusterIndex)):round(cent(2,clusterIndex))+2*centroidSize ,2) = 255;
	disp2( round(cent(1,clusterIndex)) :round(cent(1,clusterIndex))+2*centroidSize ,  round(cent(2,clusterIndex)):round(cent(2,clusterIndex))+2*centroidSize ,3) = 0;

    if ( strcmp(withFigures,'WITH_FIGURES') )
        figure, imshow(uint8(disp2))
    end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Choosing the mask under the assumption we look for only two clusters. %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numOfConrensInCluster1 = idx_cluster(1,1,1) + idx_cluster(sizeCurImage(1),1,1) + idx_cluster(1,sizeCurImage(2),1) + idx_cluster(sizeCurImage(1),sizeCurImage(2),1);
if (numOfConrensInCluster1>=3)
    mask =  idx_cluster(:,:,2);
else
    mask =  idx_cluster(:,:,1);
end;

%%%%%%%%%%%%%%%
%% ProcessingMask %%
%%%%%%%%%%%%%%%

mask = cleanNoise(mask);

se = strel('line',5,1);

maskDilate = imdilate(mask,se);
maskDilateAndFilledHoles = imfill(maskDilate,'holes');
maskDilateAndFilledHolesAndErode = imerode(maskDilateAndFilledHoles,se);


%% Clean Noise

% Choosing mask for forthur processing:
maskProcessed = cleanNoise(maskDilateAndFilledHolesAndErode);

if ( strcmp(withFigures,'WITH_FIGURES') )
    figure,imshow(maskProcessed);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%                                                    %%%%%%%%%%%%%
%%%%%%%%%%%%%               edge detection           %%%%%%%%%%%%%
%%%%%%%%%%%%%                                                    %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% canny edge:

curImageForEdges = doubleG;
primaryForeground = maskProcessed;
primaryBackground =  1 - maskProcessed;

curImageForEdges = medfilt2(curImageForEdges,[20 20],'symmetric');
if ( strcmp(withFigures,'WITH_FIGURES') )
    figure,imshow(curImageForEdges)
end

alpha = 0.25;
gaussFilt = fspecial('gaussian', [3 3], 2);
details = curImageForEdges -  imfilter(curImageForEdges, gaussFilt,'same','replicate');
sharpened6 = curImageForEdges + alpha*details;

if ( strcmp(withFigures,'WITH_FIGURES') )
    figure,imshow(sharpened6);
    title('sharpened image gor edge detection');
end

sharpenedTemp(sizeCurImage(1)+2*centroidSize,sizeCurImage(2)+2*centroidSize) = 0;
sharpenedTemp(centroidSize+1:sizeCurImage(1)+centroidSize,centroidSize+1:sizeCurImage(2)+centroidSize) = sharpened6;

edgeTemp = edge(sharpened6,'canny');

if ( strcmp(withFigures,'WITH_FIGURES') )
    figure,imshow(edgeTemp);
end

se = strel('diamond',3);
x = (edgeTemp+ maskProcessed)>0;

x =  imdilate(x,se);
x = extractLargestConnectedComponent(x);
x = imerode(x,se);

x = imfill(x,'holes');
x = cleanNoise(x);

x = imerode(x,se);
x = cleanNoise(x);
x = imdilate(x,se);

relativeNumPixelEdgesInForeground = sum(primaryForeground(:).*edgeTemp(:))/sum(primaryForeground(:));
relativeNumPixelEdgesInBackground = sum(primaryBackground(:).*edgeTemp(:))/sum(primaryBackground(:));

% allowing phase of using Edges to improve only if background is relatively
% clean comparing to foreground. In future, Can be added a comparison of num edges
% relative to num of pixels.
withCannyEdgeImprovment = 0;
if (relativeNumPixelEdgesInForeground > 3*relativeNumPixelEdgesInBackground)
    withCannyEdgeImprovment = 1;
end;

withCannyEdgeImprovment

if (withCannyEdgeImprovment==1)
    maskProcessed = double((x + maskProcessed)>0);
end;

end;

