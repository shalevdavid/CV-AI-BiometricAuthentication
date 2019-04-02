%% mainScript
function  [Results] = MainScript(InputImg, DBtype, withFigures, id)

% DBtype =  'openedHand';

    Results.input_img = InputImg;
    [Results.maskProcessed, Results.distanceVector, Results.features] = MainProcessing(Results.input_img, withFigures, DBtype);
    
    Results.maskProcessed(:,:,1) = Results.maskProcessed(:,:,1);
    Results.maskProcessed(:,:,2) = Results.maskProcessed(:,:,1);
    Results.maskProcessed(:,:,3) =Results.maskProcessed(:,:,1);
    Results.ROI = Results.input_img.*uint8(Results.maskProcessed);
    
    [Results.valid, Results.mark] = Authentication2(Results, DBtype, id);

