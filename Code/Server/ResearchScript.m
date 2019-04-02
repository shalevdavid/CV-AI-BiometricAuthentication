%% ResearchScript - Running Offline for DataBase creation.
% ResearchScript('','openedHand',0,036764751,036764751,6)
function [Results] = ResearchScript( dirSrcFiles, DBtype, withFigures, id, idDontCare, numOfbaseImgforAnswerCreation)

dirSrcFiles = [pwd '\DataBase\' DBtype '\' num2str(id) '\Learning\'];

srcFiles = dir(strcat(dirSrcFiles,'*.jpg'));  % the folder in which ur images exists

for i = 1 : length(srcFiles)
    filename = strcat(dirSrcFiles,srcFiles(i).name);
    Results(i).filename =filename;
    Results(i).srcfilename = srcFiles(i).name;
    Results(i).input_img = imread(filename);
%      [Results(i).maskProcessed, Results(i).distanceVector, Results(i).features] = MainProcessing(Results(i).input_img, 'WITH_FIGURES');
    [Results(i).maskProcessed, Results(i).distanceVector, Results(i).features] = MainProcessing(Results(i).input_img, 'NO_FIGURES', DBtype);
end

for i = 1 : length(srcFiles)
    Results(i).maskProcessed(:,:,1) = Results(i).maskProcessed(:,:,1);
    Results(i).maskProcessed(:,:,2) = Results(i).maskProcessed(:,:,1);
    Results(i).maskProcessed(:,:,3) =Results(i).maskProcessed(:,:,1);
    Results(i).ROI = Results(i).input_img.*uint8(Results(i).maskProcessed);  
    
    if strcmp(withFigures,'WITH_FIGURES');
%         Results(i).distanceHist = hist(round(Results(i).distanceVector));
%         figure,imshow(Results(i).maskProcessed); title(strcat('maskProcessed ',NUM2STR(i)));
        figure, imshow(Results(i).ROI); title(strcat(strcat('ROI ',NUM2STR(i)), strcat(': ',Results(i).srcfilename)));
%         figure,hist(round(Results(i).distanceVector)); title(strcat('distanceVector ',NUM2STR(i)));
%         figure, plot(Results(i).distanceHist); title(strcat('distanceHist ',NUM2STR(i)));
    end
end

if strcmp(withFigures,'WITH_FIGURES');
    Results(i).features
end;
    
DBHand = Results;
        
for i=1:length(DBHand)        
	minRelativeDistanceValue.samples(i) = DBHand(i).features.minRelativeDistanceValue;
	relativeDistanceVectorAverageValue.samples(i) = DBHand(i).features.relativeDistanceVectorAverageValue;
%         maxCorrDistanceVector
%         normalizedRelativeDistanceHist.samples(:,i) = DBHand(i).features.normalizedRelativeDistanceHist;
%         maxCorrHist
	portionOfHistogramBinsToHalfVal.samples(i) = DBHand(i).features.portionOfHistogramBinsToHalfVal;
	portionOfHistogramBinsToAveVal.samples(i) = DBHand(i).features.portionOfHistogramBinsToAveVal;
	rectPortions.samples(i) = DBHand(i).features.rectPortions;
	centroidRowRelativeLocation.samples(i) = DBHand(i).features.centroidRowRelativeLocation;
	centroidColRelativeLocation.samples(i) = DBHand(i).features.centroidColRelativeLocation;
%          convexHull
    if (strcmp(DBtype,'openedHand'))
        AreaRelations.A1.samples(i) = DBHand(i).features.AreaRelations.A1;
        AreaRelations.A2.samples(i) = DBHand(i).features.AreaRelations.A2;
        AreaRelations.A3.samples(i) = DBHand(i).features.AreaRelations.A3;
        EdgeLengthRelations.EL1.samples(i) = DBHand(i).features.EdgeLengthRelations.EL1;
        EdgeLengthRelations.EL2.samples(i) = DBHand(i).features.EdgeLengthRelations.EL2;
        EdgeLengthRelations.EL3.samples(i) = DBHand(i).features.EdgeLengthRelations.EL3;
        T1.Eccentricity.samples(i) = DBHand(i).features.T1.Eccentricity;
        T1.Solidity.samples(i) = DBHand(i).features.T1.Solidity;
        T1.relationBetweenMinorAxisToMajorAxisLengths.samples(i) = DBHand(i).features.T1.relationBetweenMinorAxisToMajorAxisLengths;
        T2.relationBetweenMinorAxisToMajorAxisLengths.samples(i) = DBHand(i).features.T2.relationBetweenMinorAxisToMajorAxisLengths;
        T3.relationBetweenMinorAxisToMajorAxisLengths.samples(i) = DBHand(i).features.T3.relationBetweenMinorAxisToMajorAxisLengths;
    end
    if strcmp(DBtype,'halfOpenedHand')
        AreaRelations.A1.samples(i) = DBHand(i).features.AreaRelations.A1;
        EdgeLengthRelations.EL1.samples(i) = DBHand(i).features.EdgeLengthRelations.EL1;
    end
	Eccentricity.samples(i) = DBHand(i).features.Eccentricity;
	relationBetweenMinorAxisToMajorAxisLengths.samples(i) = DBHand(i).features.relationBetweenMinorAxisToMajorAxisLengths;
	Solidity.samples(i) = DBHand(i).features.Solidity;
%         shapeRepresentation
%         convexHullShapeRepresentation
    convHullToMaskEdgesRatio.samples(i) = DBHand(i).features.convHullToMaskEdgesRatio;
end
   
if strcmp(DBtype,'halfOpenedHand')
	DataBase.halfOpenedHand = DBHand;
end

if strcmp(DBtype,'closedHand')
	DataBase.closedHand = DBHand;
end

if strcmp(DBtype,'openedHand')
	DataBase.openedHand = DBHand;
end

DataBase.minRelativeDistanceValue.stats = CalcStatisticalParams2(minRelativeDistanceValue.samples);
DataBase.relativeDistanceVectorAverageValue.stats = CalcStatisticalParams2(relativeDistanceVectorAverageValue.samples);
%         maxCorrDistanceVector
%         normalizedRelativeDistanceHist.samples(:,i)
%         maxCorrHist
DataBase.portionOfHistogramBinsToHalfVal.stats = CalcStatisticalParams2(portionOfHistogramBinsToHalfVal.samples);
DataBase.portionOfHistogramBinsToAveVal.stats = CalcStatisticalParams2(portionOfHistogramBinsToAveVal.samples);
DataBase.rectPortions.stats = CalcStatisticalParams2(rectPortions.samples);
DataBase.centroidRowRelativeLocation.stats = CalcStatisticalParams2(centroidRowRelativeLocation.samples);
DataBase.centroidColRelativeLocation.stats = CalcStatisticalParams2(centroidColRelativeLocation.samples);
%          convexHull

if (strcmp(DBtype,'openedHand'))
	DataBase.AreaRelations.A1.stats = CalcStatisticalParams2(AreaRelations.A1.samples);
	DataBase.AreaRelations.A2.stats = CalcStatisticalParams2(AreaRelations.A2.samples);
	DataBase.AreaRelations.A3.stats = CalcStatisticalParams2(AreaRelations.A3.samples);
    DataBase.EdgeLengthRelations.EL1.stats = CalcStatisticalParams2(EdgeLengthRelations.EL1.samples);
    DataBase.EdgeLengthRelations.EL2.stats = CalcStatisticalParams2(EdgeLengthRelations.EL2.samples);
    DataBase.EdgeLengthRelations.EL3.stats = CalcStatisticalParams2(EdgeLengthRelations.EL3.samples);    
    DataBase.T1.Eccentricity.stats = CalcStatisticalParams2(T1.Eccentricity.samples);
    DataBase.T1.Solidity.stats = CalcStatisticalParams2(T1.Solidity.samples);
    DataBase.T1.relationBetweenMinorAxisToMajorAxisLengths.stats = CalcStatisticalParams2(T1.relationBetweenMinorAxisToMajorAxisLengths.samples);
    DataBase.T2.relationBetweenMinorAxisToMajorAxisLengths.stats = CalcStatisticalParams2(T2.relationBetweenMinorAxisToMajorAxisLengths.samples);
    DataBase.T3.relationBetweenMinorAxisToMajorAxisLengths.stats = CalcStatisticalParams2(T3.relationBetweenMinorAxisToMajorAxisLengths.samples);
end
        
if (strcmp(DBtype,'halfOpenedHand'))
	DataBase.AreaRelations.A1.stats = CalcStatisticalParams2(AreaRelations.A1.samples);
    DataBase.EdgeLengthRelations.EL1.stats = CalcStatisticalParams2(EdgeLengthRelations.EL1.samples);
end

DataBase.Eccentricity.stats = CalcStatisticalParams2(Eccentricity.samples);
DataBase.relationBetweenMinorAxisToMajorAxisLengths.stats = CalcStatisticalParams2(relationBetweenMinorAxisToMajorAxisLengths.samples);
DataBase.Solidity.stats = CalcStatisticalParams2(Solidity.samples);
%         shapeRepresentation
%         convexHullShapeRepresentation
DataBase.convHullToMaskEdgesRatio.stats = CalcStatisticalParams2(convHullToMaskEdgesRatio.samples);

fileNameSave = [dirSrcFiles 'FeaturesDataBase'];
save(fileNameSave, 'DataBase');
clear 'DataBase';

answerForClientDir = [pwd '\DataBase\' DBtype '\' num2str(id) '\AnswerForClient\'];
inputImageFileName =  [dirSrcFiles num2str(numOfbaseImgforAnswerCreation) '.jpg'];
AnswerFileName =  [answerForClientDir 'pictureWithId.jpg'];
CreateAnswerForClient(answerForClientDir, id, inputImageFileName, AnswerFileName);


