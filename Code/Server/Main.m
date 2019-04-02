function [Results] = Main(InputImg, withFigures)
% clc;
% clear all;
% close all;

extLibs = 'D:\shalev\Projects\WorkspaceMatlab\ExternalLibs';
addpath(genpath(extLibs));

%% Calling mainScript - For single image test on Server and for running client app

Results = MainScript(InputImg, 'openedHand', withFigures);

if ( strcmp(withFigures,'WITH_FIGURES') )
    imshow(Results.ROI);
end;

save 'C:\Users\user\Desktop\resultsMain'

%% Calling MainScript - For Scale Invariance test on Server

% tic
% InputImg05 = imresize(InputImg,0.5);
% InputImg2 = imresize(InputImg,2);
% Results1 = MainScript(InputImg, 'openedHand', 'NO_FIGURES');;
% Results05 = MainScript(InputImg05, 'openedHand', 'NO_FIGURES');;
% Results2 = MainScript(InputImg2, 'openedHand', 'NO_FIGURES');;
% Results1.features
% Results05.features
% Results2.features
% 
% Results.Results1 = Results1;
% Results.Results05 = Results05;
% Results.Results2 = Results2;
% 
% toc

%% Calling mainScript - For multi image test on Server

% tic;
% 
% % dirSrcFiles = 'C:\wamp\www\ImageProcessingOnMobile3562IDCCourseProject\DataBase\ShalevHandPic\openedHand\'; % Shalev
% % dirSrcFiles = 'C:\wamp\www\ImageProcessingOnMobile3562IDCCourseProject\DataBase\MomHandPic\openedHand\'; % Mom
% dirSrcFiles = 'C:\wamp\www\ImageProcessingOnMobile3562IDCCourseProject\DataBase\DadyHandPic\openedHand\'; % Dad
% % dirSrcFiles = 'C:\wamp\www\ImageProcessingOnMobile3562IDCCourseProject\DataBase\ShalevHandPic\other-Hacking\'; % HACK
% 
% srcFiles = dir(strcat(dirSrcFiles,'*.jpg'));  % the folder in which ur images exists
% 
% for i = 1 : length(srcFiles)
% 	srcFiles(i).name
%     
%     filename = strcat(dirSrcFiles,srcFiles(i).name);
%     InputImg = imread(filename);
% 
% %     InputImg = imresize(InputImg,[480,640]);
% %     imwrite( InputImg, strcat(dirSrcFiles,strcat(NUM2STR(i),'.jpg')));
%     
%     Results(i) = MainScript(InputImg, 'openedHand', 'NO_FIGURES');
% end
% 
% if strcmp(withFigures,'WITH_FIGURES')
%     for i=1:length(Results)
%         Results(i).valid
%         figure, imshow(Results(i).ROI), title(strcat(NUM2STR( Results(i).valid ),srcFiles(i).name) )
% %         figure, imshow( Results(i).features.t2, title(strcat(NUM2STR( Results(i).valid ),srcFiles(i).name) ))
% %         figure, imshow( Results(i).features.t3, title(strcat(NUM2STR( Results(i).valid ),srcFiles(i).name) ))
%     end
% end
% 
% save 'C:\Users\user\Desktop\resultsMain_Shalev'
% toc;

%% Calling ResearchScript - For DataBase creation on Server (offline)

% tic;
dirSrcFiles = 'C:\wamp\www\ImageProcessingOnMobile3562IDCCourseProject\DataBase\ShalevHandPic\openedHand\DataBaseLearn\usingOtsu\';
% dirSrcFiles = 'C:\wamp\www\ImageProcessingOnMobile3562IDCCourseProject\DataBase\MomHandPic\openedHand\DataBaseLearn\usingOtsu\';
% dirSrcFiles = 'C:\wamp\www\ImageProcessingOnMobile3562IDCCourseProject\DataBase\DadyHandPic\openedHand\DataBaseLearn\usingOtsu\';
Results.openedHand = ResearchScript(dirSrcFiles, 'openedHand', withFigures);

save 'C:\Users\user\Desktop\resultsResearchScriptMain'
% toc;

%% Functions Area:

% %% mainScript
% function  [Results] = MainScript(InputImg, DBtype, withFigures)
% 
%     Results.input_img = InputImg;
%     [Results.maskProcessed, Results.distanceVector, Results.features] = MainProcessing(Results.input_img, withFigures, DBtype);
%     
%     Results.maskProcessed(:,:,1) = Results.maskProcessed(:,:,1);
%     Results.maskProcessed(:,:,2) = Results.maskProcessed(:,:,1);
%     Results.maskProcessed(:,:,3) =Results.maskProcessed(:,:,1);
%     Results.ROI = Results.input_img.*uint8(Results.maskProcessed);
%     
%     [Results.valid, Results.mark] = Authentication(Results, 'openedHand');
%  
%     
% %% ResearchScript - Running Offline for DataBase creation.
% function [Results] = ResearchScript(dirSrcFiles, DBtype, withFigures)
% 
% srcFiles = dir(strcat(dirSrcFiles,'*.jpg'));  % the folder in which ur images exists
% 
% for i = 1 : length(srcFiles)
%     filename = strcat(dirSrcFiles,srcFiles(i).name);
%     Results(i).filename =filename;
%     Results(i).srcfilename = srcFiles(i).name;
%     Results(i).input_img = imread(filename);
% %      [Results(i).maskProcessed, Results(i).distanceVector, Results(i).features] = MainProcessing(Results(i).input_img, 'WITH_FIGURES');
%     [Results(i).maskProcessed, Results(i).distanceVector, Results(i).features] = MainProcessing(Results(i).input_img, 'NO_FIGURES', DBtype);
% end
% 
% for i = 1 : length(srcFiles)
%     Results(i).maskProcessed(:,:,1) = Results(i).maskProcessed(:,:,1);
%     Results(i).maskProcessed(:,:,2) = Results(i).maskProcessed(:,:,1);
%     Results(i).maskProcessed(:,:,3) =Results(i).maskProcessed(:,:,1);
%     Results(i).ROI = Results(i).input_img.*uint8(Results(i).maskProcessed);  
%     
%     if strcmp(withFigures,'WITH_FIGURES');
% %         Results(i).distanceHist = hist(round(Results(i).distanceVector));
% %         figure,imshow(Results(i).maskProcessed); title(strcat('maskProcessed ',NUM2STR(i)));
%         figure, imshow(Results(i).ROI); title(strcat(strcat('ROI ',NUM2STR(i)), strcat(': ',Results(i).srcfilename)));
% %         figure,hist(round(Results(i).distanceVector)); title(strcat('distanceVector ',NUM2STR(i)));
% %         figure, plot(Results(i).distanceHist); title(strcat('distanceHist ',NUM2STR(i)));
%     end
% end
% 
% Results(i).features
%     
% DBHand = Results;
%         
% for i=1:length(DBHand)        
% 	minRelativeDistanceValue.samples(i) = DBHand(i).features.minRelativeDistanceValue;
% 	relativeDistanceVectorAverageValue.samples(i) = DBHand(i).features.relativeDistanceVectorAverageValue;
% %         maxCorrDistanceVector
% %         normalizedRelativeDistanceHist.samples(:,i) = DBHand(i).features.normalizedRelativeDistanceHist;
% %         maxCorrHist
% 	portionOfHistogramBinsToHalfVal.samples(i) = DBHand(i).features.portionOfHistogramBinsToHalfVal;
% 	portionOfHistogramBinsToAveVal.samples(i) = DBHand(i).features.portionOfHistogramBinsToAveVal;
% 	rectPortions.samples(i) = DBHand(i).features.rectPortions;
% 	centroidRowRelativeLocation.samples(i) = DBHand(i).features.centroidRowRelativeLocation;
% 	centroidColRelativeLocation.samples(i) = DBHand(i).features.centroidColRelativeLocation;
% %          convexHull
%     if (strcmp(DBtype,'openedHand'))
%         AreaRelations.A1.samples(i) = DBHand(i).features.AreaRelations.A1;
%         AreaRelations.A2.samples(i) = DBHand(i).features.AreaRelations.A2;
%         AreaRelations.A3.samples(i) = DBHand(i).features.AreaRelations.A3;
%         EdgeLengthRelations.EL1.samples(i) = DBHand(i).features.EdgeLengthRelations.EL1;
%         EdgeLengthRelations.EL2.samples(i) = DBHand(i).features.EdgeLengthRelations.EL2;
%         EdgeLengthRelations.EL3.samples(i) = DBHand(i).features.EdgeLengthRelations.EL3;
%         T1.Eccentricity.samples(i) = DBHand(i).features.T1.Eccentricity;
%         T1.Solidity.samples(i) = DBHand(i).features.T1.Solidity;
%         T1.relationBetweenMinorAxisToMajorAxisLengths.samples(i) = DBHand(i).features.T1.relationBetweenMinorAxisToMajorAxisLengths;
%         T2.relationBetweenMinorAxisToMajorAxisLengths.samples(i) = DBHand(i).features.T2.relationBetweenMinorAxisToMajorAxisLengths;
%         T3.relationBetweenMinorAxisToMajorAxisLengths.samples(i) = DBHand(i).features.T3.relationBetweenMinorAxisToMajorAxisLengths;
%     end
%     if strcmp(DBtype,'halfOpenedHand')
%         AreaRelations.A1.samples(i) = DBHand(i).features.AreaRelations.A1;
%         EdgeLengthRelations.EL1.samples(i) = DBHand(i).features.EdgeLengthRelations.EL1;
%     end
% 	Eccentricity.samples(i) = DBHand(i).features.Eccentricity;
% 	relationBetweenMinorAxisToMajorAxisLengths.samples(i) = DBHand(i).features.relationBetweenMinorAxisToMajorAxisLengths;
% 	Solidity.samples(i) = DBHand(i).features.Solidity;
% %         shapeRepresentation
% %         convexHullShapeRepresentation
%     convHullToMaskEdgesRatio.samples(i) = DBHand(i).features.convHullToMaskEdgesRatio;
% end
%    
% if strcmp(DBtype,'halfOpenedHand')
% 	DataBase.halfOpenedHand = DBHand;
% end
% 
% if strcmp(DBtype,'closedHand')
% 	DataBase.closedHand = DBHand;
% end
% 
% if strcmp(DBtype,'openedHand')
% 	DataBase.openedHand = DBHand;
% end
% 
% DataBase.minRelativeDistanceValue.stats = CalcStatisticalParams(minRelativeDistanceValue.samples);
% DataBase.relativeDistanceVectorAverageValue.stats = CalcStatisticalParams(relativeDistanceVectorAverageValue.samples);
% %         maxCorrDistanceVector
% %         normalizedRelativeDistanceHist.samples(:,i)
% %         maxCorrHist
% DataBase.portionOfHistogramBinsToHalfVal.stats = CalcStatisticalParams(portionOfHistogramBinsToHalfVal.samples);
% DataBase.portionOfHistogramBinsToAveVal.stats = CalcStatisticalParams(portionOfHistogramBinsToAveVal.samples);
% DataBase.rectPortions.stats = CalcStatisticalParams(rectPortions.samples);
% DataBase.centroidRowRelativeLocation.stats = CalcStatisticalParams(centroidRowRelativeLocation.samples);
% DataBase.centroidColRelativeLocation.stats = CalcStatisticalParams(centroidColRelativeLocation.samples);
% %          convexHull
% 
% if (strcmp(DBtype,'openedHand'))
% 	DataBase.AreaRelations.A1.stats = CalcStatisticalParams(AreaRelations.A1.samples);
% 	DataBase.AreaRelations.A2.stats = CalcStatisticalParams(AreaRelations.A2.samples);
% 	DataBase.AreaRelations.A3.stats = CalcStatisticalParams(AreaRelations.A3.samples);
%     DataBase.EdgeLengthRelations.EL1.stats = CalcStatisticalParams(EdgeLengthRelations.EL1.samples);
%     DataBase.EdgeLengthRelations.EL2.stats = CalcStatisticalParams(EdgeLengthRelations.EL2.samples);
%     DataBase.EdgeLengthRelations.EL3.stats = CalcStatisticalParams(EdgeLengthRelations.EL3.samples);    
%     DataBase.T1.Eccentricity.stats = CalcStatisticalParams(T1.Eccentricity.samples);
%     DataBase.T1.Solidity.stats = CalcStatisticalParams(T1.Solidity.samples);
%     DataBase.T1.relationBetweenMinorAxisToMajorAxisLengths.stats = CalcStatisticalParams(T1.relationBetweenMinorAxisToMajorAxisLengths.samples);
%     DataBase.T2.relationBetweenMinorAxisToMajorAxisLengths.stats = CalcStatisticalParams(T2.relationBetweenMinorAxisToMajorAxisLengths.samples);
%     DataBase.T3.relationBetweenMinorAxisToMajorAxisLengths.stats = CalcStatisticalParams(T3.relationBetweenMinorAxisToMajorAxisLengths.samples);
% end
%         
% if (strcmp(DBtype,'halfOpenedHand'))
% 	DataBase.AreaRelations.A1.stats = CalcStatisticalParams(AreaRelations.A1.samples);
%     DataBase.EdgeLengthRelations.EL1.stats = CalcStatisticalParams(EdgeLengthRelations.EL1.samples);
% end
% 
% DataBase.Eccentricity.stats = CalcStatisticalParams(Eccentricity.samples);
% DataBase.relationBetweenMinorAxisToMajorAxisLengths.stats = CalcStatisticalParams(relationBetweenMinorAxisToMajorAxisLengths.samples);
% DataBase.Solidity.stats = CalcStatisticalParams(Solidity.samples);
% %         shapeRepresentation
% %         convexHullShapeRepresentation
% DataBase.convHullToMaskEdgesRatio.stats = CalcStatisticalParams(convHullToMaskEdgesRatio.samples);
% 
% 
% save C:\Users\user\Desktop\DataBaseTemp DataBase
% 

% %% Authentication - CheckValidity of end-user
%  function  [valid, mark] = Authentication(Results, DBtype)  
%      
% %     load  'DataBase8_Shalev.mat'    
%     load  'DataBase8_ShalevHashValues.mat'    % relevant for GetMark2
% %     load  'DataBase9_Mom.mat'  
% %     load  'DataBase10_Dady.mat'  
%     
%     Results.features.mark = zeros(1,50)-1;
%     
%     Results.features.mark(1) = GetMark2(Results.features.minRelativeDistanceValue, DataBase.minRelativeDistanceValue.stats);
%     Results.features.mark(2) = GetMark2(Results.features.relativeDistanceVectorAverageValue, DataBase.relativeDistanceVectorAverageValue.stats);
% %     Results.features.mark(3) = GetMark2(Results.features.relativeDistanceVectorAverageValue, relativeDistanceVectorAverageValue.stats);
% %     Results.features.mark(4) = GetMark2(Results.features.relativeDistanceVectorAverageValue, relativeDistanceVectorAverageValue.stats);
% %     Results.features.mark(5) = GetMark2(Results.features.relativeDistanceVectorAverageValue, relativeDistanceVectorAverageValue.stats);
%     Results.features.mark(6) = GetMark2(Results.features.portionOfHistogramBinsToHalfVal, DataBase.portionOfHistogramBinsToHalfVal.stats);
%     Results.features.mark(7) = GetMark2(Results.features.portionOfHistogramBinsToAveVal, DataBase.portionOfHistogramBinsToAveVal.stats);
% %     Results.features.mark(8) = GetMark2(Results.features.rectPortions, DataBase.rectPortions.stats);
% %     Results.features.mark(9) = GetMark2(Results.features.centroidRowRelativeLocation, DataBase.centroidRowRelativeLocation.stats);
% %     Results.features.mark(10) = GetMark2(Results.features.centroidColRelativeLocation, DataBase.centroidColRelativeLocation.stats);
% %     Results.features.mark(11) = GetMark2(Results.features.relativeDistanceVectorAverageValue, relativeDistanceVectorAverageValue.stats);
%     Results.features.mark(12) = GetMark2(Results.features.AreaRelations.A1, DataBase.AreaRelations.A1.stats);
%     Results.features.mark(13) = GetMark2(Results.features.AreaRelations.A2, DataBase.AreaRelations.A2.stats);
%     Results.features.mark(14) = GetMark2(Results.features.AreaRelations.A3, DataBase.AreaRelations.A3.stats);
%     
%     
%     Results.features.mark(15) = GetMark2(Results.features.Eccentricity, DataBase.Eccentricity.stats);
%     Results.features.mark(16) = GetMark2(Results.features.relationBetweenMinorAxisToMajorAxisLengths, DataBase.relationBetweenMinorAxisToMajorAxisLengths.stats);
%     Results.features.mark(17) = GetMark2(Results.features.Solidity, DataBase.Solidity.stats);
% %     Results.features.mark(18) = GetMark2(Results.features.relativeDistanceVectorAverageValue, relativeDistanceVectorAverageValue.stats);
% %     Results.features.mark(19) = GetMark2(Results.features.relativeDistanceVectorAverageValue, relativeDistanceVectorAverageValue.stats);
%     Results.features.mark(20) = GetMark2(Results.features.convHullToMaskEdgesRatio, DataBase.convHullToMaskEdgesRatio.stats);  
%     Results.features.mark(21) = GetMark2(Results.features.EdgeLengthRelations.EL1, DataBase.EdgeLengthRelations.EL1.stats);
%     Results.features.mark(22) = GetMark2(Results.features.EdgeLengthRelations.EL2, DataBase.EdgeLengthRelations.EL2.stats);
%     Results.features.mark(23) = GetMark2(Results.features.EdgeLengthRelations.EL3, DataBase.EdgeLengthRelations.EL3.stats);
%     Results.features.mark(24) = GetMark2(Results.features.T1.Eccentricity, DataBase.T1.Eccentricity.stats);
%     Results.features.mark(25) = GetMark2(Results.features.T1.Solidity, DataBase.T1.Solidity.stats);
%     Results.features.mark(26) = GetMark2(Results.features.T1.relationBetweenMinorAxisToMajorAxisLengths, DataBase.T1.relationBetweenMinorAxisToMajorAxisLengths.stats);
%     Results.features.mark(35) = GetMark2(Results.features.T2.relationBetweenMinorAxisToMajorAxisLengths, DataBase.T2.relationBetweenMinorAxisToMajorAxisLengths.stats);
%     Results.features.mark(36) = GetMark2(Results.features.T3.relationBetweenMinorAxisToMajorAxisLengths, DataBase.T3.relationBetweenMinorAxisToMajorAxisLengths.stats);
%     
%  
%     mark = Results.features.mark;
%    
% 	valid = 0;
%     
%     relevantMarks = mark;
%     indexes = find(relevantMarks==-1);
%     relevantMarks(indexes)=[];
%     
%     score = mean(relevantMarks);
%     
%     if (score==100)
%         valid = 1;
%     end
%  
%     
% %% CalcStatisticalParams
%  function [stats] = CalcStatisticalParams(samples)
%     stats.ave = mean(samples);
%     stats.sigma = sqrt(var(samples,1));
%     stats.min = min(samples);
%     stats.max = max(samples);
%     stats.maxDistFromAve = max( stats.max - stats.ave ,...
%                                                          stats.ave - stats.min );
%                                                      
%     
%     stats.ave = DataHash(floor(stats.ave*10^3));    % Saving hash value of floor value since floating point of matlab is not accurate.
% 	stats.sigma = floor(stats.sigma*10^3);
%  
%                                                      
% %% GetMark of new observation
%  function mark = GetMark(val, stats)
% 	if ( abs(val - stats.ave)<=(3*stats.sigma) )
%         mark = 100;
%     else
%         mark = 0;
% 	end;
% 
%     
%% GetMark2 of new observfation
%  function mark = GetMark2(val, stats)         
%      
%      mark = 0;
%      val = floor(val*10^3);
%      
%      hashAve = stats.ave;
%      
%      for i=-3*(stats.sigma+1):3*(stats.sigma+1)
%          curHash=DataHash(val+i);
%          if ( curHash == hashAve )
%              mark = 100;
%              break;
%          end;
%      end;
    
     
% %% MainProcessing
% function [maskProcessed, distanceVector, features] = MainProcessing(input_img, withFigures, DBtype)
% 
% maskProcessed = CreateMask(input_img, withFigures, 'Otsu');
% [distanceVector, features] = ExtractFeatures(maskProcessed, withFigures, DBtype);
% 

% %% CreateMask function - 2Means and EdgeDetection Based.
% function maskProcessed = CreateMask(input_img, withFigures,type)
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%                                      %%%%%%%%%%%%
% %%%%%%%%%%%%%       Extract Images     %%%%%%%%%%%%
% %%%%%%%%%%%%%                                      %%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% R = input_img(:,:,1);
% G = input_img(:,:,2);
% B = input_img(:,:,3);
% 
% YCbCr = rgb2ycbcr(input_img);
% Y = YCbCr(:,:,1);
% Cb = YCbCr(:,:,2);
% Cr = YCbCr(:,:,3);
% 
% HSV = rgb2hsv(input_img);
% H = HSV(:,:,1);
% S = HSV(:,:,2);
% V = HSV(:,:,3);
% 
% doubleR = double(R)/255;
% doubleG = double(G)/255;
% doubleB = double(B)/255;
% doubleY = double(Y)/255;
% doubleCb = double(Cb)/255;
% doubleCr = double(Cr)/255;
% doubleH = double(H);
% doubleS = double(S);
% doubleV = double(V);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%                           %%%%%%%%%%%%
% %%%%%%%%%%          Otsu         %%%%%%%%%%%%
% %%%%%%%%%%                           %%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% if (strcmp(type,'Otsu'))
%     level = graythresh(input_img);
%     maskProcessed = double(im2bw(input_img,level));
%     
%     sizeCurImage = size(maskProcessed);
%     % choose mask:
%     numOfConrensInCluster =  maskProcessed(1,1) +  maskProcessed(sizeCurImage(1),1) +  maskProcessed(1,sizeCurImage(2)) + maskProcessed(sizeCurImage(1),sizeCurImage(2));
%     if (numOfConrensInCluster>=3)
%         maskProcessed = 1- maskProcessed;
%     end;    
%     
%     maskProcessed = cleanNoise(maskProcessed);
% end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%                                      %%%%%%%%%%%%
% %%%%%%%%%%%%%          K-MEANS          %%%%%%%%%%%%
% %%%%%%%%%%%%%                                      %%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% if (strcmp(type,'ownUsingKmeans'))
% 
% K=2;
% curImage = doubleCr;
% 
% % ','Replicates',5 - to avoid local-minima.
% opts = statset('Display','final');
% [IDX,C] = KMEANS(curImage(:),K,'start','uniform', 'emptyaction','singleton','Replicates',5,'Options',opts);
% 
% sizeCurImage = size(curImage);
% idx = reshape(IDX,[sizeCurImage(1),sizeCurImage(2)]);
% 
% %% Extract binary clusters:
% 
% numOfClusters = K;
% 
% for clusterIndex = 1:numOfClusters
% 	idx_cluster(:,:,clusterIndex) = (double(idx == clusterIndex));
%     if ( strcmp(withFigures,'WITH_FIGURES') )
%         figure, imshow(idx_cluster(:,:,clusterIndex));
%     end
% end;
% 
% %% find Centroids:
% 
% for clusterIndex = 1:numOfClusters
%     measurements = regionprops(double(idx == clusterIndex), 'Centroid');
%     cent(1,clusterIndex) = measurements.Centroid(2);
%     cent(2,clusterIndex) = measurements.Centroid(1);
% end;
% 
% % Display all clusters in one image - Red coloured
% disp(:,:,1) = idx*255/numOfClusters;
% disp(:,:,2) = 0;
% disp(:,:,3) = 0;
% 
% if ( strcmp(withFigures,'WITH_FIGURES') )
%     figure, imshow(uint8(disp))
% end
% 
% %% Draw Centroids:
% 
% % Notice that image is increased by centroidSize for the
% % case of centerMass being in the borders of the image.
% 
% centroidSize = 10; %Coter
% 
% for clusterIndex = 1:numOfClusters
% 
% 	disp(:,:,1) = double(idx == clusterIndex)*255;
% 	disp(:,:,2) = 0;
% 	disp(:,:,3) = 0;
% 
% 	disp2(sizeCurImage(1)+2*centroidSize,sizeCurImage(2)+2*centroidSize,3) = 0;
% 	disp2(centroidSize+1:sizeCurImage(1)+centroidSize,centroidSize+1:sizeCurImage(2)+centroidSize,:) = disp;
% 
% 	%% Centroid color chosen to be Green.
% 	disp2( round(cent(1,clusterIndex)) :round(cent(1,clusterIndex))+2*centroidSize ,  round(cent(2,clusterIndex)):round(cent(2,clusterIndex))+2*centroidSize ,1) = 0;
% 	disp2( round(cent(1,clusterIndex)) :round(cent(1,clusterIndex))+2*centroidSize ,  round(cent(2,clusterIndex)):round(cent(2,clusterIndex))+2*centroidSize ,2) = 255;
% 	disp2( round(cent(1,clusterIndex)) :round(cent(1,clusterIndex))+2*centroidSize ,  round(cent(2,clusterIndex)):round(cent(2,clusterIndex))+2*centroidSize ,3) = 0;
% 
%     if ( strcmp(withFigures,'WITH_FIGURES') )
%         figure, imshow(uint8(disp2))
%     end
% 
% end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Choosing the mask under the assumption we look for only two clusters. %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% numOfConrensInCluster1 = idx_cluster(1,1,1) + idx_cluster(sizeCurImage(1),1,1) + idx_cluster(1,sizeCurImage(2),1) + idx_cluster(sizeCurImage(1),sizeCurImage(2),1);
% if (numOfConrensInCluster1>=3)
%     mask =  idx_cluster(:,:,2);
% else
%     mask =  idx_cluster(:,:,1);
% end;
% 
% %%%%%%%%%%%%%%%
% %% ProcessingMask %%
% %%%%%%%%%%%%%%%
% 
% mask = cleanNoise(mask);
% 
% se = strel('line',5,1);
% 
% maskDilate = imdilate(mask,se);
% maskDilateAndFilledHoles = imfill(maskDilate,'holes');
% maskDilateAndFilledHolesAndErode = imerode(maskDilateAndFilledHoles,se);
% 
% 
% %% Clean Noise
% 
% % Choosing mask for forthur processing:
% maskProcessed = cleanNoise(maskDilateAndFilledHolesAndErode);
% 
% if ( strcmp(withFigures,'WITH_FIGURES') )
%     figure,imshow(maskProcessed);
% end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%                                                    %%%%%%%%%%%%%
% %%%%%%%%%%%%%               edge detection           %%%%%%%%%%%%%
% %%%%%%%%%%%%%                                                    %%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% canny edge:
% 
% curImageForEdges = doubleG;
% primaryForeground = maskProcessed;
% primaryBackground =  1 - maskProcessed;
% 
% curImageForEdges = medfilt2(curImageForEdges,[20 20],'symmetric');
% if ( strcmp(withFigures,'WITH_FIGURES') )
%     figure,imshow(curImageForEdges)
% end
% 
% alpha = 0.25;
% gaussFilt = fspecial('gaussian', [3 3], 2);
% details = curImageForEdges -  imfilter(curImageForEdges, gaussFilt,'same','replicate');
% sharpened6 = curImageForEdges + alpha*details;
% 
% if ( strcmp(withFigures,'WITH_FIGURES') )
%     figure,imshow(sharpened6);
%     title('sharpened image gor edge detection');
% end
% 
% sharpenedTemp(sizeCurImage(1)+2*centroidSize,sizeCurImage(2)+2*centroidSize) = 0;
% sharpenedTemp(centroidSize+1:sizeCurImage(1)+centroidSize,centroidSize+1:sizeCurImage(2)+centroidSize) = sharpened6;
% 
% edgeTemp = edge(sharpened6,'canny');
% 
% if ( strcmp(withFigures,'WITH_FIGURES') )
%     figure,imshow(edgeTemp);
% end
% 
% se = strel('diamond',3);
% x = (edgeTemp+ maskProcessed)>0;
% 
% x =  imdilate(x,se);
% x = extractLargestConnectedComponent(x);
% x = imerode(x,se);
% 
% x = imfill(x,'holes');
% x = cleanNoise(x);
% 
% x = imerode(x,se);
% x = cleanNoise(x);
% x = imdilate(x,se);
% 
% relativeNumPixelEdgesInForeground = sum(primaryForeground(:).*edgeTemp(:))/sum(primaryForeground(:));
% relativeNumPixelEdgesInBackground = sum(primaryBackground(:).*edgeTemp(:))/sum(primaryBackground(:));
% 
% % allowing phase of using Edges to improve only if background is relatively
% % clean comparing to foreground. In future, Can be added a comparison of num edges
% % relative to num of pixels.
% withCannyEdgeImprovment = 0;
% if (relativeNumPixelEdgesInForeground > 3*relativeNumPixelEdgesInBackground)
%     withCannyEdgeImprovment = 1;
% end;
% 
% withCannyEdgeImprovment
% 
% if (withCannyEdgeImprovment==1)
%     maskProcessed = double((x + maskProcessed)>0);
% end;
% 
% end;
% 

% %%  Feature Extraction  - for a given mask (foreground) %%
% function [distanceVector, features] = ExtractFeatures(maskProcessed, withFigures, DBtype)
% 
% edgeMask2_rec = ExtractEdgeAfterExpansion(maskProcessed);
% 
% if ( strcmp(withFigures,'WITH_FIGURES') )
%     figure,imshow(maskProcessed);
%     figure,imshow(edgeMask2_rec);
% end
% 
% % calc centroids (using the 1st way)
% measurements = regionprops(maskProcessed, 'Centroid','Eccentricity','MajorAxisLength','MinorAxisLength','Solidity');
% 
% centProcessed = measurements.Centroid;
% 
% % find all indexs of the edge;
% [row col] = find(edgeMask2_rec == 1);
% 
% % representaion1: compute distanceVector from center.
% rowDiff = row-centProcessed(2);
% colDiff = col-centProcessed(1);
% diffVectors = [rowDiff,colDiff];
% distanceVector = sqrt(rowDiff.^2 + colDiff.^2);
% 
% if ( strcmp(withFigures,'WITH_FIGURES') )
%     figure, plot(distanceVector);
% end;
% 
% % Normalizing relation values to max for scale invariance.
% relativeDistanceVector = distanceVector/max(distanceVector(:));
% minRelativeDistanceValue = min(relativeDistanceVector(:));  % max value is 1.
% 
% % feature #1 - scale, rotation & translation invariance.
% %---------------
% features.minRelativeDistanceValue = minRelativeDistanceValue; % max value is 1.
% 
% numOfPixels = size(relativeDistanceVector(:));
% relativeDistanceVectorAverageValue =sum(relativeDistanceVector(:))/numOfPixels(1);
% 
% % feature #2 - scale, rotation & translation invariance.
% %---------------
% features.relativeDistanceVectorAverageValue = relativeDistanceVectorAverageValue;
% %%%%%%%%
% 
% % for i = 1:length(DBHand)
% %     imresize(DBHand(i).distanceVector, size(relativeDistanceVector));
% %     maxCorrDistanceVector(i) = MaxCorr(   relativeDistanceVector, ...
% %                                                                         imresize(DBHand(i).distanceVector, size(relativeDistanceVector)) );
% % end
% % 
% % % feature #3 - scale & translation invariance, approximately rotation invariance
% % %---------------
% % features.maxCorrDistanceVector = maxCorrDistanceVector;
% % %%%%%%%%
% 
% relativeDistanceHist = hist(relativeDistanceVector);
% normRelativeDistanceHist = relativeDistanceHist/numOfPixels(1);
% % normlized histogram
% if ( strcmp(withFigures,'WITH_FIGURES') )
%     figure, plot(relativeDistanceHist); title('relativeDistanceHist');
% end;
% 
% % feature #4 - scale & translation invariance, approximately rotation invariance
% %---------------
% features.normalizedRelativeDistanceHist = normRelativeDistanceHist; % normalized histogram.
% %%%%%%%%
% 
% % for i = 1:length(DBHand)
% %     maxCorrHist(i) = MaxCorr(   features.normalizedRelativeDistanceHist, ...
% %                                             DBHand(i).features.normalizedRelativeDistanceHist );
% % end
% % 
% % % feature #5 - scale & translation invariance, approximately rotation invariance
% % %---------------
% % features.maxCorrHist = maxCorrHist;
% % %%%%%%%%
% 
% binaryRelativeDistanceVector = round(relativeDistanceVector);
% 
% % feature #6 - scale & translation invariance, approximately rotation invariance
% %---------------
% features.portionOfHistogramBinsToHalfVal = sum(binaryRelativeDistanceVector(:)==0)/sum(binaryRelativeDistanceVector(:)==1);
% %%%%%%%%
% 
% binaryRelativeDistanceVector = (relativeDistanceVector>relativeDistanceVectorAverageValue);
% 
% % feature #7 - scale & translation invariance, approximately rotation invariance
% %---------------
% features.portionOfHistogramBinsToAveVal = sum(binaryRelativeDistanceVector(:)==0)/sum(binaryRelativeDistanceVector(:)==1);
% %%%%%%%%
% 
% % feature #8 - scale & translation invariace only
% %---------------
% features.rectPortions = (max(col) - min(col))/(max(row)-min(row));
% %%%%%%%%
% 
% % feature #9 - scale & translation invariace only
% %---------------
% features.centroidRowRelativeLocation = (centProcessed(2)-min(row))/(max(row)-min(row));
% %%%%%%%%
% 
% % feature #10 - scale & translation invariace only
% %---------------
% features.centroidColRelativeLocation = (centProcessed(1)-min(col))/(max(col)-min(col));
% %%%%%%%%
% 
% % feature #11
% %---------------
% BW = maskProcessed(:,:,1);
% features.convexHull = bwconvhull(BW);
% %%%%%%%%
% 
% % feature #12,13,14,21,22,23,24,25,26,35,36 - scale, rotation & translation invariance.
% %----------------------------------------------------
% if (strcmp(DBtype,'openedHand'))
%     y = features.convexHull - maskProcessed;
%     t1 = extractLargestConnectedComponent(y);
%     t2 = extractLargestConnectedComponent(y-t1);
%     t3 = extractLargestConnectedComponent(y-t2-t1);
%     AreaT1 = sum(t1(:));
%     AreaT2 = sum(t2(:));
%     AreaT3 = sum(t3(:));
%     
%     AreaMask = sum(maskProcessed(:));
%     
%     features.AreaRelations.A1 = AreaT1/AreaMask; %12
%     features.AreaRelations.A2 = AreaT1/AreaT2; %13
%     features.AreaRelations.A3 = AreaT1/AreaT3; %14
%     
% 	features.t1 = t1; % for debug only
% 	features.t2 = t2; % for debug only
% 	features.t3 = t3; % for debug only
%     
%     EdgeMask = ExtractEdgeAfterExpansion(maskProcessed);   
%     EdgeT1 = ExtractEdgeAfterExpansion(t1);
%     EdgeT2 = ExtractEdgeAfterExpansion(t2);
%     EdgeT3 = ExtractEdgeAfterExpansion(t3);
%     
%     EdgeLengthMask = sum(EdgeMask(:));
%     EdgeLengthT1 = sum(EdgeT1(:));
%     EdgeLengthT2 = sum(EdgeT2(:));
%     EdgeLengthT3 = sum(EdgeT3(:));
%     
%     features.EdgeLengthRelations.EL1 = EdgeLengthT1/EdgeLengthMask; %21
%     features.EdgeLengthRelations.EL2 = EdgeLengthT1/EdgeLengthT2; %22
%     features.EdgeLengthRelations.EL3 = EdgeLengthT1/EdgeLengthT3; %23
%     
% 	T1.measurments = regionprops(t1, 'Centroid','Eccentricity','MajorAxisLength','MinorAxisLength','Solidity');
%     features.T1.Eccentricity = T1.measurments.Eccentricity; %24
%     features.T1.Solidity = T1.measurments.Solidity; %25
%     features.T1.relationBetweenMinorAxisToMajorAxisLengths = T1.measurments.MinorAxisLength/T1.measurments.MajorAxisLength; %26 
%     
%     T2.measurments = regionprops(t2, 'Centroid','Eccentricity','MajorAxisLength','MinorAxisLength','Solidity');
%     T3.measurments = regionprops(t3, 'Centroid','Eccentricity','MajorAxisLength','MinorAxisLength','Solidity');
%     a =  [T2.measurments.MinorAxisLength,T2.measurments.MajorAxisLength,T3.measurments.MinorAxisLength,T3.measurments.MajorAxisLength];
%     a = a/max(a(:));
%     
%     features.T2.relationBetweenMinorAxisToMajorAxisLengths = T2.measurments.MinorAxisLength/T2.measurments.MajorAxisLength; %35
%     features.T3.relationBetweenMinorAxisToMajorAxisLengths = T3.measurments.MinorAxisLength/T3.measurments.MajorAxisLength; %36
%     
% end
% 
% if (strcmp(DBtype,'halfOpenedHand'))
%     y = features.convexHull - maskProcessed;
%     t1 = extractLargestConnectedComponent(y);
%     AreaT1 = sum(t1(:));
% 
%     AreaMask = sum(maskProcessed(:));
% 
%     features.AreaRelations.A1 = AreaT1/AreaMask;
%     
%     EdgeMask = ExtractEdgeAfterExpansion(maskProcessed);
%     EdgeT1 = ExtractEdgeAfterExpansion(t1);
%     
% 	EdgeLengthMask = sum(EdgeMask(:));
%     EdgeLengthT1 = sum(EdgeT1(:));
%     
%     features.EdgeLengthRelations.EL1 = EdgeLengthT1/EdgeLengthMask; 
%     
%     features.T1.measurments = regionprops(t1, 'Centroid','Eccentricity','MajorAxisLength','MinorAxisLength','Solidity');
%     features.T1.Eccentricity = T1.measurments.Eccentricity;
%     features.T1.Solidity = T1.measurments.Solidity;
%     features.T1.relationBetweenMinorAxisToMajorAxisLengths = T1.measurements.MinorAxisLength/T1.measurements.MajorAxisLength;
%     
% end
% 
% if (strcmp(DBtype,'closedHand'))
%     features.AreaRelations = 1; % Degenerated feature for closedHand.
% end
% %%%%%%%%
% 
% % feature #15 - scale, rotation & translation invariance.
% %---------------
% features.Eccentricity = measurements.Eccentricity;
% %%%%%%%%
% 
% % feature #16 - scale, rotation & translation invariance.
% %---------------
% features.relationBetweenMinorAxisToMajorAxisLengths = measurements.MinorAxisLength/measurements.MajorAxisLength;
% %%%%%%%%
% 
% % feature #17 - scale, rotation & translation invariance.
% %---------------
% features.Solidity = measurements.Solidity;
% %%%%%%%%
% 
% theta = atan2(rowDiff,colDiff);
% [shapeRepresentation.theta, sotredIndex] = sort(theta);
% shapeRepresentation.r =  relativeDistanceVector(sotredIndex); % r is between 0 to 1.
% 
% % feature #18 - scale, rotation & translation invariance.
% %---------------
% features.shapeRepresentation = shapeRepresentation;
% %%%%%%%% 
% 
% convexHullShapeRepresentation = SortedShapeRepresentation(features.convexHull);
%  % Normalization to be between 0 to 1
% convexHullShapeRepresentation.r = convexHullShapeRepresentation.r/max(convexHullShapeRepresentation.r(:));
% 
% % feature #19 - scale, rotation & translation invariance.
% %---------------
% features.convexHullShapeRepresentation = convexHullShapeRepresentation;
% %%%%%%%%
% 
% % Extracting edges of a maskTemp (including the borders)
% convHullEdge_rec = ExtractEdgeAfterExpansion(features.convexHull);
% 
% % feature #20 - scale, rotation & translation invariance.
% %---------------
% features.convHullToMaskEdgesRatio = sum(convHullEdge_rec(:))/sum(edgeMask2_rec(:));
% %%%%%%%%
% 
% fastVer = 1;
% if (fastVer ~=1)
%     % finding local max using decimation and findpeaks fnction.
%     h = (1/10)*ones(1,10);
%     x = conv(convexHullShapeRepresentation.r,h);
%     xDec = x(1:10:size(convexHullShapeRepresentation.r,1));
%     [PKS,LOCS]= findpeaks(xDec);
%     features.Peaks = sort(PKS);
%  
%     max(convexHullShapeRepresentation.r(:))
%     min(convexHullShapeRepresentation.r(:))
% 
%     % feature #27-34 - scale, rotation & translation invariance.
%     %---------------
%     features.Hu.I1 = EtaIJ(maskProcessed,2,0)+EtaIJ(maskProcessed,0,2);
%     features.Hu.I2 = (EtaIJ(maskProcessed,2,0)-EtaIJ(maskProcessed,0,2))^2+4*EtaIJ(maskProcessed,1,1);
%     features.Hu.I3 = (EtaIJ(maskProcessed,3,0)-3*EtaIJ(maskProcessed,1,2))^2+(3*EtaIJ(maskProcessed,2,1)-EtaIJ(maskProcessed,0,3))^2;
%     features.Hu.I4 = (EtaIJ(maskProcessed,3,0)+EtaIJ(maskProcessed,1,2))^2+(EtaIJ(maskProcessed,2,1)+EtaIJ(maskProcessed,0,3))^2;
%     % features.Hu.I4 = (EtaIJ(maskProcessed, 3,0)+EtaIJ(maskProcessed, 1,2))^2 + (EtaIJ(maskProcessed, 2,1)+EtaIJ(maskProcessed, 0,3))^2
% 
%     features.Hu.I5 = (EtaIJ(maskProcessed, 3,0)-3*EtaIJ(maskProcessed, 1,2))*(EtaIJ(maskProcessed, 3,0)+EtaIJ(maskProcessed, 1,2))*( (EtaIJ(maskProcessed, 3,0)+EtaIJ(maskProcessed, 1,2))^2 - 3*(EtaIJ(maskProcessed, 2,1)+EtaIJ(maskProcessed, 0,3))^2)...
%                                 +(3*EtaIJ(maskProcessed,2,1)-EtaIJ(maskProcessed,0,3))*(EtaIJ(maskProcessed,2,1)+EtaIJ(maskProcessed,0,3))*(3*(EtaIJ(maskProcessed, 3,0)+EtaIJ(maskProcessed, 1,2))^2-(EtaIJ(maskProcessed, 2,1)+EtaIJ(maskProcessed, 0,3))^2);
% 
%     features.Hu.I6 = (EtaIJ(maskProcessed,2,0)- EtaIJ(maskProcessed,0,2))*( (EtaIJ(maskProcessed,3,0)+ EtaIJ(maskProcessed,1,2))^2 - (EtaIJ(maskProcessed,2,1)+ EtaIJ(maskProcessed,0,3))^2)...
%                                 +4* EtaIJ(maskProcessed,1,2)*(EtaIJ(maskProcessed,3,0)+ EtaIJ(maskProcessed,1,2))*( EtaIJ(maskProcessed,2,1)+ EtaIJ(maskProcessed,0,3));
% 
%     features.Hu.I7 = (3* EtaIJ(maskProcessed,2,1)- EtaIJ(maskProcessed,0,3))*( EtaIJ(maskProcessed,3,0)+ EtaIJ(maskProcessed,1,2))*(( EtaIJ(maskProcessed,3,0)+ EtaIJ(maskProcessed,2,1))^2-3*( EtaIJ(maskProcessed,2,1)+ EtaIJ(maskProcessed,0,3))^2)...
%                                 -( EtaIJ(maskProcessed,3,0)-3* EtaIJ(maskProcessed,1,2))*( EtaIJ(maskProcessed,2,1)+ EtaIJ(maskProcessed,0,3))*(3*( EtaIJ(maskProcessed,3,0)+ EtaIJ(maskProcessed,1,2))^2-( EtaIJ(maskProcessed,2,1)+ EtaIJ(maskProcessed,0,3))^2);
% end;
% 

% %% Extracting Edges After Expansion(maskTemp)
% function edgeMask2_rec = ExtractEdgeAfterExpansion(maskTemp)
% % Extracting edges of a maskTemp (including the borders)
% % done by expanding the image beforehand and Shrinking after.    
% sizeCurImage = size(maskTemp);
% centroidSize = 10;
% 
% mask2(sizeCurImage(1)+2*centroidSize,sizeCurImage(2)+2*centroidSize) = 0;
% mask2(centroidSize+1:sizeCurImage(1)+centroidSize,centroidSize+1:sizeCurImage(2)+centroidSize) = maskTemp;
% edgeMask2 = edge(mask2,'canny');
% edgeMask2_rec = edgeMask2( centroidSize+1 :size(edgeMask2,1)-centroidSize  ,  centroidSize+1 :size(edgeMask2,2)-centroidSize );
% 

% %% Clean Noise function
% function cleanedMask = cleanNoise(mask)
% 
% % Remove noise by filling holes in background (closing backgroung).
% % Assuming all ROI's of foregroung cross the borders of the image.
% cleanedMask = 1 - imfill(1-mask,'holes');
% 
% % Leave only largest connectivity group - Assuming there is only one ROI (Region of Interest).
% % Note: for multiple ROI's, could be done Cannonicaly/iteratively n times to leave n  largest connectivity groups ROI's.
% maskProcessedNoise = cleanedMask;
% 
% CC = bwconncomp(maskProcessedNoise);
% numPixels = cellfun(@numel,CC.PixelIdxList);
% [biggest,idxTemp] = max(numPixels);
% maskProcessedNoise(CC.PixelIdxList{idxTemp}) = 0;
% 
% cleanedMask = cleanedMask - maskProcessedNoise;
% 

% %%  extract Largest Connected Component function
% function maskPost = extractLargestConnectedComponent(maskPre)
% maskPost = maskPre;
% 
% CC = bwconncomp(maskPre);
% numPixels = cellfun(@numel,CC.PixelIdxList);
% [biggest,idxTemp] = max(numPixels);
% maskPre(CC.PixelIdxList{idxTemp}) = 0;
% 
% maskPost = maskPost - maskPre;
% 

% %% Get Shape Moments
% function Mpq = MomentPQ(mask,p,q)
% col = 1:size(mask,2);
% row = 1:size(mask,1);
% [COL,ROW] = meshgrid(col,row);
% 
% int = (COL.^p).*(ROW.^q).*mask;
%         
% Mpq = sum(int(:));
% 

% %% Get Shape Moments
% function MUEpq = MuePQ(mask,p,q)
% col = 1:size(mask,2);
% row = 1:size(mask,1);
% [COL,ROW] = meshgrid(col,row);
% 
% measurment = regionprops(mask, 'Centroid');
% centroid = measurment.Centroid;
% 
% ColCent = centroid(1);
% RowCent = centroid(2);
% 
% int = ((COL-ColCent).^p).*((ROW-RowCent).^q).*mask;
%         
% MUEpq = sum(int(:));
% 

% %% Get Shape Moments
% function ETAij = EtaIJ(mask,i,j)
% ETAij = MuePQ(mask,i,j)/(MuePQ(mask,0,0)^(1+(i+j)/2));
%     

% %%  changeDynamicRange function
% function outputImage = changeDynamicRange(inputImage,minVal,maxVal)
% 
% fmin = min(inputImage(:));
% fmax = max(inputImage(:));
% 
% outputImage = (inputImage - fmin)/(fmax-fmin);
% 
% outputImage = (maxVal-minVal)*outputImage + minVal;
% 

% %% Shape Representaion function
% function [shapeRepresentation] = SortedShapeRepresentation(BW)
% 
% centroidSize = 10;
% 
% mask2(size(BW,1)+2*centroidSize,size(BW,2)+2*centroidSize) = 0;
% mask2(centroidSize+1:size(BW,1)+centroidSize,centroidSize+1:size(BW,2)+centroidSize) = BW;
% 
% edgeMask2 = edge(mask2,'canny');
% 
% edgeMask2_rec = edgeMask2( centroidSize+1 :size(edgeMask2,1)-centroidSize  ,  centroidSize+1 :size(edgeMask2,2)-centroidSize );
% 
% meas = regionprops(BW,'centroid');
% 
% centBW = meas.Centroid;
% 
% % find all indexs of the edge;
% [row2 col2] = find(edgeMask2_rec == 1);
% 
% % representaion1: compute distanceVector from center.
% rowDiff2 = row2-centBW(2);
% colDiff2 = col2-centBW(1);
% distanceVector2 = sqrt(rowDiff2.^2 + colDiff2.^2);
% 
% theta = atan2(rowDiff2,colDiff2);
% [shapeRepresentation.theta, sotredIndex] = sort(theta);
% shapeRepresentation.r = distanceVector2(sotredIndex); % r is between 0 to 1.
%         

% %% Maximum Correlation - The function assumes non-normalized inputs x1,x2.
% function maxCorr = MaxCorr(x1,x2)
% 
% x1 = x1/sqrt(sum(x1.^2));
% x2 = x2/sqrt(sum(x2.^2)); 
%  
% fftCalc = ifft(abs(fft(x1).*(fft(x2))));
% maxCorr = fftCalc(1);
% 
