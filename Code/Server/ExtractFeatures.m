%%  Feature Extraction  - for a given mask (foreground) %%
function [distanceVector, features] = ExtractFeatures(maskProcessed, withFigures, DBtype)

edgeMask2_rec = ExtractEdgeAfterExpansion(maskProcessed);

if ( strcmp(withFigures,'WITH_FIGURES') )
    figure,imshow(maskProcessed);
    figure,imshow(edgeMask2_rec);
end

% calc centroids (using the 1st way)
measurements = regionprops(maskProcessed, 'Centroid','Eccentricity','MajorAxisLength','MinorAxisLength','Solidity');

centProcessed = measurements.Centroid;

% find all indexs of the edge;
[row col] = find(edgeMask2_rec == 1);

% representaion1: compute distanceVector from center.
rowDiff = row-centProcessed(2);
colDiff = col-centProcessed(1);
diffVectors = [rowDiff,colDiff];
distanceVector = sqrt(rowDiff.^2 + colDiff.^2);

if ( strcmp(withFigures,'WITH_FIGURES') )
    figure, plot(distanceVector);
end;

% Normalizing relation values to max for scale invariance.
relativeDistanceVector = distanceVector/max(distanceVector(:));
minRelativeDistanceValue = min(relativeDistanceVector(:));  % max value is 1.

% feature #1 - scale, rotation & translation invariance.
%---------------
features.minRelativeDistanceValue = minRelativeDistanceValue; % max value is 1.

numOfPixels = size(relativeDistanceVector(:));
relativeDistanceVectorAverageValue =sum(relativeDistanceVector(:))/numOfPixels(1);

% feature #2 - scale, rotation & translation invariance.
%---------------
features.relativeDistanceVectorAverageValue = relativeDistanceVectorAverageValue;
%%%%%%%%

% for i = 1:length(DBHand)
%     imresize(DBHand(i).distanceVector, size(relativeDistanceVector));
%     maxCorrDistanceVector(i) = MaxCorr(   relativeDistanceVector, ...
%                                                                         imresize(DBHand(i).distanceVector, size(relativeDistanceVector)) );
% end
% 
% % feature #3 - scale & translation invariance, approximately rotation invariance
% %---------------
% features.maxCorrDistanceVector = maxCorrDistanceVector;
% %%%%%%%%

relativeDistanceHist = hist(relativeDistanceVector);
normRelativeDistanceHist = relativeDistanceHist/numOfPixels(1);
% normlized histogram
if ( strcmp(withFigures,'WITH_FIGURES') )
    figure, plot(relativeDistanceHist); title('relativeDistanceHist');
end;

% feature #4 - scale & translation invariance, approximately rotation invariance
%---------------
features.normalizedRelativeDistanceHist = normRelativeDistanceHist; % normalized histogram.
%%%%%%%%

% for i = 1:length(DBHand)
%     maxCorrHist(i) = MaxCorr(   features.normalizedRelativeDistanceHist, ...
%                                             DBHand(i).features.normalizedRelativeDistanceHist );
% end
% 
% % feature #5 - scale & translation invariance, approximately rotation invariance
% %---------------
% features.maxCorrHist = maxCorrHist;
% %%%%%%%%

binaryRelativeDistanceVector = round(relativeDistanceVector);

% feature #6 - scale & translation invariance, approximately rotation invariance
%---------------
features.portionOfHistogramBinsToHalfVal = sum(binaryRelativeDistanceVector(:)==0)/sum(binaryRelativeDistanceVector(:)==1);
%%%%%%%%

binaryRelativeDistanceVector = (relativeDistanceVector>relativeDistanceVectorAverageValue);

% feature #7 - scale & translation invariance, approximately rotation invariance
%---------------
features.portionOfHistogramBinsToAveVal = sum(binaryRelativeDistanceVector(:)==0)/sum(binaryRelativeDistanceVector(:)==1);
%%%%%%%%

% feature #8 - scale & translation invariace only
%---------------
features.rectPortions = (max(col) - min(col))/(max(row)-min(row));
%%%%%%%%

% feature #9 - scale & translation invariace only
%---------------
features.centroidRowRelativeLocation = (centProcessed(2)-min(row))/(max(row)-min(row));
%%%%%%%%

% feature #10 - scale & translation invariace only
%---------------
features.centroidColRelativeLocation = (centProcessed(1)-min(col))/(max(col)-min(col));
%%%%%%%%

% feature #11
%---------------
BW = maskProcessed(:,:,1);
features.convexHull = bwconvhull(BW);
%%%%%%%%

% feature #12,13,14,21,22,23,24,25,26,35,36 - scale, rotation & translation invariance.
%----------------------------------------------------
if (strcmp(DBtype,'openedHand'))
    y = features.convexHull - maskProcessed;
    t1 = extractLargestConnectedComponent(y);
    t2 = extractLargestConnectedComponent(y-t1);
    t3 = extractLargestConnectedComponent(y-t2-t1);
    AreaT1 = sum(t1(:));
    AreaT2 = sum(t2(:));
    AreaT3 = sum(t3(:));
    
    AreaMask = sum(maskProcessed(:));
    
    features.AreaRelations.A1 = AreaT1/AreaMask; %12
    features.AreaRelations.A2 = AreaT1/AreaT2; %13
    features.AreaRelations.A3 = AreaT1/AreaT3; %14
    
	features.t1 = t1; % for debug only
	features.t2 = t2; % for debug only
	features.t3 = t3; % for debug only
    
    EdgeMask = ExtractEdgeAfterExpansion(maskProcessed);   
    EdgeT1 = ExtractEdgeAfterExpansion(t1);
    EdgeT2 = ExtractEdgeAfterExpansion(t2);
    EdgeT3 = ExtractEdgeAfterExpansion(t3);
    
    EdgeLengthMask = sum(EdgeMask(:));
    EdgeLengthT1 = sum(EdgeT1(:));
    EdgeLengthT2 = sum(EdgeT2(:));
    EdgeLengthT3 = sum(EdgeT3(:));
    
    features.EdgeLengthRelations.EL1 = EdgeLengthT1/EdgeLengthMask; %21
    features.EdgeLengthRelations.EL2 = EdgeLengthT1/EdgeLengthT2; %22
    features.EdgeLengthRelations.EL3 = EdgeLengthT1/EdgeLengthT3; %23
    
	T1.measurments = regionprops(t1, 'Centroid','Eccentricity','MajorAxisLength','MinorAxisLength','Solidity');
    features.T1.Eccentricity = T1.measurments.Eccentricity; %24
    features.T1.Solidity = T1.measurments.Solidity; %25
    features.T1.relationBetweenMinorAxisToMajorAxisLengths = T1.measurments.MinorAxisLength/T1.measurments.MajorAxisLength; %26 
    
    T2.measurments = regionprops(t2, 'Centroid','Eccentricity','MajorAxisLength','MinorAxisLength','Solidity');
    T3.measurments = regionprops(t3, 'Centroid','Eccentricity','MajorAxisLength','MinorAxisLength','Solidity');
    a =  [T2.measurments.MinorAxisLength,T2.measurments.MajorAxisLength,T3.measurments.MinorAxisLength,T3.measurments.MajorAxisLength];
    a = a/max(a(:));
    
    features.T2.relationBetweenMinorAxisToMajorAxisLengths = T2.measurments.MinorAxisLength/T2.measurments.MajorAxisLength; %35
    features.T3.relationBetweenMinorAxisToMajorAxisLengths = T3.measurments.MinorAxisLength/T3.measurments.MajorAxisLength; %36
    
end

if (strcmp(DBtype,'halfOpenedHand'))
    y = features.convexHull - maskProcessed;
    t1 = extractLargestConnectedComponent(y);
    AreaT1 = sum(t1(:));

    AreaMask = sum(maskProcessed(:));

    features.AreaRelations.A1 = AreaT1/AreaMask;
    
    EdgeMask = ExtractEdgeAfterExpansion(maskProcessed);
    EdgeT1 = ExtractEdgeAfterExpansion(t1);
    
	EdgeLengthMask = sum(EdgeMask(:));
    EdgeLengthT1 = sum(EdgeT1(:));
    
    features.EdgeLengthRelations.EL1 = EdgeLengthT1/EdgeLengthMask; 
    
    features.T1.measurments = regionprops(t1, 'Centroid','Eccentricity','MajorAxisLength','MinorAxisLength','Solidity');
    features.T1.Eccentricity = T1.measurments.Eccentricity;
    features.T1.Solidity = T1.measurments.Solidity;
    features.T1.relationBetweenMinorAxisToMajorAxisLengths = T1.measurements.MinorAxisLength/T1.measurements.MajorAxisLength;
    
end

if (strcmp(DBtype,'closedHand'))
    features.AreaRelations = 1; % Degenerated feature for closedHand.
end
%%%%%%%%

% feature #15 - scale, rotation & translation invariance.
%---------------
features.Eccentricity = measurements.Eccentricity;
%%%%%%%%

% feature #16 - scale, rotation & translation invariance.
%---------------
features.relationBetweenMinorAxisToMajorAxisLengths = measurements.MinorAxisLength/measurements.MajorAxisLength;
%%%%%%%%

% feature #17 - scale, rotation & translation invariance.
%---------------
features.Solidity = measurements.Solidity;
%%%%%%%%

theta = atan2(rowDiff,colDiff);
[shapeRepresentation.theta, sotredIndex] = sort(theta);
shapeRepresentation.r =  relativeDistanceVector(sotredIndex); % r is between 0 to 1.

% feature #18 - scale, rotation & translation invariance.
%---------------
features.shapeRepresentation = shapeRepresentation;
%%%%%%%% 

convexHullShapeRepresentation = SortedShapeRepresentation(features.convexHull);
 % Normalization to be between 0 to 1
convexHullShapeRepresentation.r = convexHullShapeRepresentation.r/max(convexHullShapeRepresentation.r(:));

% feature #19 - scale, rotation & translation invariance.
%---------------
features.convexHullShapeRepresentation = convexHullShapeRepresentation;
%%%%%%%%

% Extracting edges of a maskTemp (including the borders)
convHullEdge_rec = ExtractEdgeAfterExpansion(features.convexHull);

% feature #20 - scale, rotation & translation invariance.
%---------------
features.convHullToMaskEdgesRatio = sum(convHullEdge_rec(:))/sum(edgeMask2_rec(:));
%%%%%%%%

fastVer = 1;
if (fastVer ~=1)
    % finding local max using decimation and findpeaks fnction.
    h = (1/10)*ones(1,10);
    x = conv(convexHullShapeRepresentation.r,h);
    xDec = x(1:10:size(convexHullShapeRepresentation.r,1));
    [PKS,LOCS]= findpeaks(xDec);
    features.Peaks = sort(PKS);
 
    max(convexHullShapeRepresentation.r(:))
    min(convexHullShapeRepresentation.r(:))

    % feature #27-34 - scale, rotation & translation invariance.
    %---------------
    features.Hu.I1 = EtaIJ(maskProcessed,2,0)+EtaIJ(maskProcessed,0,2);
    features.Hu.I2 = (EtaIJ(maskProcessed,2,0)-EtaIJ(maskProcessed,0,2))^2+4*EtaIJ(maskProcessed,1,1);
    features.Hu.I3 = (EtaIJ(maskProcessed,3,0)-3*EtaIJ(maskProcessed,1,2))^2+(3*EtaIJ(maskProcessed,2,1)-EtaIJ(maskProcessed,0,3))^2;
    features.Hu.I4 = (EtaIJ(maskProcessed,3,0)+EtaIJ(maskProcessed,1,2))^2+(EtaIJ(maskProcessed,2,1)+EtaIJ(maskProcessed,0,3))^2;
    % features.Hu.I4 = (EtaIJ(maskProcessed, 3,0)+EtaIJ(maskProcessed, 1,2))^2 + (EtaIJ(maskProcessed, 2,1)+EtaIJ(maskProcessed, 0,3))^2

    features.Hu.I5 = (EtaIJ(maskProcessed, 3,0)-3*EtaIJ(maskProcessed, 1,2))*(EtaIJ(maskProcessed, 3,0)+EtaIJ(maskProcessed, 1,2))*( (EtaIJ(maskProcessed, 3,0)+EtaIJ(maskProcessed, 1,2))^2 - 3*(EtaIJ(maskProcessed, 2,1)+EtaIJ(maskProcessed, 0,3))^2)...
                                +(3*EtaIJ(maskProcessed,2,1)-EtaIJ(maskProcessed,0,3))*(EtaIJ(maskProcessed,2,1)+EtaIJ(maskProcessed,0,3))*(3*(EtaIJ(maskProcessed, 3,0)+EtaIJ(maskProcessed, 1,2))^2-(EtaIJ(maskProcessed, 2,1)+EtaIJ(maskProcessed, 0,3))^2);

    features.Hu.I6 = (EtaIJ(maskProcessed,2,0)- EtaIJ(maskProcessed,0,2))*( (EtaIJ(maskProcessed,3,0)+ EtaIJ(maskProcessed,1,2))^2 - (EtaIJ(maskProcessed,2,1)+ EtaIJ(maskProcessed,0,3))^2)...
                                +4* EtaIJ(maskProcessed,1,2)*(EtaIJ(maskProcessed,3,0)+ EtaIJ(maskProcessed,1,2))*( EtaIJ(maskProcessed,2,1)+ EtaIJ(maskProcessed,0,3));

    features.Hu.I7 = (3* EtaIJ(maskProcessed,2,1)- EtaIJ(maskProcessed,0,3))*( EtaIJ(maskProcessed,3,0)+ EtaIJ(maskProcessed,1,2))*(( EtaIJ(maskProcessed,3,0)+ EtaIJ(maskProcessed,2,1))^2-3*( EtaIJ(maskProcessed,2,1)+ EtaIJ(maskProcessed,0,3))^2)...
                                -( EtaIJ(maskProcessed,3,0)-3* EtaIJ(maskProcessed,1,2))*( EtaIJ(maskProcessed,2,1)+ EtaIJ(maskProcessed,0,3))*(3*( EtaIJ(maskProcessed,3,0)+ EtaIJ(maskProcessed,1,2))^2-( EtaIJ(maskProcessed,2,1)+ EtaIJ(maskProcessed,0,3))^2);
end;

