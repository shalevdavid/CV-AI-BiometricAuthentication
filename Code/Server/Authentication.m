%% Authentication - CheckValidity of end-user
 function  [valid, mark] = Authentication(Results, DBtype, id)  
     
% %     load  'DataBase8_Shalev.mat'    
%     load  'DataBase8_ShalevHashValues.mat'    % relevant for GetMark2
% %     load  'DataBase9_Mom.mat'  
% %     load  'DataBase10_Dady.mat'  
    
    dirSrcFiles = [pwd '\DataBase\' DBtype '\' num2str(id) '\Learning\' 'FeaturesDataBase.mat'];
    load(dirSrcFiles);

    Results.features.mark = zeros(1,50)-1;
    
    Results.features.mark(1) = GetMark(Results.features.minRelativeDistanceValue, DataBase.minRelativeDistanceValue.stats);
    Results.features.mark(2) = GetMark(Results.features.relativeDistanceVectorAverageValue, DataBase.relativeDistanceVectorAverageValue.stats);
%     Results.features.mark(3) = GetMark(Results.features.relativeDistanceVectorAverageValue, relativeDistanceVectorAverageValue.stats);
%     Results.features.mark(4) = GetMark(Results.features.relativeDistanceVectorAverageValue, relativeDistanceVectorAverageValue.stats);
%     Results.features.mark(5) = GetMark(Results.features.relativeDistanceVectorAverageValue, relativeDistanceVectorAverageValue.stats);
    Results.features.mark(6) = GetMark(Results.features.portionOfHistogramBinsToHalfVal, DataBase.portionOfHistogramBinsToHalfVal.stats);
    Results.features.mark(7) = GetMark(Results.features.portionOfHistogramBinsToAveVal, DataBase.portionOfHistogramBinsToAveVal.stats);
%     Results.features.mark(8) = GetMark(Results.features.rectPortions, DataBase.rectPortions.stats);
%     Results.features.mark(9) = GetMark(Results.features.centroidRowRelativeLocation, DataBase.centroidRowRelativeLocation.stats);
%     Results.features.mark(10) = GetMark(Results.features.centroidColRelativeLocation, DataBase.centroidColRelativeLocation.stats);
%     Results.features.mark(11) = GetMark(Results.features.relativeDistanceVectorAverageValue, relativeDistanceVectorAverageValue.stats);
    Results.features.mark(12) = GetMark(Results.features.AreaRelations.A1, DataBase.AreaRelations.A1.stats);
    Results.features.mark(13) = GetMark(Results.features.AreaRelations.A2, DataBase.AreaRelations.A2.stats);
    Results.features.mark(14) = GetMark(Results.features.AreaRelations.A3, DataBase.AreaRelations.A3.stats);
    
    
    Results.features.mark(15) = GetMark(Results.features.Eccentricity, DataBase.Eccentricity.stats);
    Results.features.mark(16) = GetMark(Results.features.relationBetweenMinorAxisToMajorAxisLengths, DataBase.relationBetweenMinorAxisToMajorAxisLengths.stats);
    Results.features.mark(17) = GetMark(Results.features.Solidity, DataBase.Solidity.stats);
%     Results.features.mark(18) = GetMark(Results.features.relativeDistanceVectorAverageValue, relativeDistanceVectorAverageValue.stats);
%     Results.features.mark(19) = GetMark(Results.features.relativeDistanceVectorAverageValue, relativeDistanceVectorAverageValue.stats);
    Results.features.mark(20) = GetMark(Results.features.convHullToMaskEdgesRatio, DataBase.convHullToMaskEdgesRatio.stats);  
    Results.features.mark(21) = GetMark(Results.features.EdgeLengthRelations.EL1, DataBase.EdgeLengthRelations.EL1.stats);
    Results.features.mark(22) = GetMark(Results.features.EdgeLengthRelations.EL2, DataBase.EdgeLengthRelations.EL2.stats);
    Results.features.mark(23) = GetMark(Results.features.EdgeLengthRelations.EL3, DataBase.EdgeLengthRelations.EL3.stats);
    Results.features.mark(24) = GetMark(Results.features.T1.Eccentricity, DataBase.T1.Eccentricity.stats);
    Results.features.mark(25) = GetMark(Results.features.T1.Solidity, DataBase.T1.Solidity.stats);
    Results.features.mark(26) = GetMark(Results.features.T1.relationBetweenMinorAxisToMajorAxisLengths, DataBase.T1.relationBetweenMinorAxisToMajorAxisLengths.stats);
    Results.features.mark(35) = GetMark(Results.features.T2.relationBetweenMinorAxisToMajorAxisLengths, DataBase.T2.relationBetweenMinorAxisToMajorAxisLengths.stats);
    Results.features.mark(36) = GetMark(Results.features.T3.relationBetweenMinorAxisToMajorAxisLengths, DataBase.T3.relationBetweenMinorAxisToMajorAxisLengths.stats);
    
 
    mark = Results.features.mark;
   
	valid = 0;
    
    relevantMarks = mark;
    indexes = find(relevantMarks==-1);
    relevantMarks(indexes)=[];
    
    score = mean(relevantMarks);
    
    if (score==100)
        valid = 1;
    end
 
  

