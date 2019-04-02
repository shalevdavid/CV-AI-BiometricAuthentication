%% MainProcessing
function [maskProcessed, distanceVector, features] = MainProcessing(input_img, withFigures, DBtype)

maskProcessed = CreateMask(input_img, withFigures, 'Otsu');
[distanceVector, features] = ExtractFeatures(maskProcessed, withFigures, DBtype);

