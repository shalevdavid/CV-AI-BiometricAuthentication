function OutputImage = PreProcessing(InputImage, Median, Gaussian, Sharp, alpha)

    OutputImage = InputImage;    
    gaussFilt = fspecial('gaussian', [3 3], 2);
    
    if ( strcmp(Median,'MEDIAN') )
        OutputImage = medfilt2(OutputImage,[3 3],'symmetric');
    end;
    if ( strcmp(Gaussian,'GAUSSIAN') )
        OutputImage =  imfilter(OutputImage, gaussFilt,'same','replicate');
    end;
    
    if ( strcmp(Sharp,'SHARP') )
        OutputImage = medfilt2(InputImage,[3 3],'symmetric');
        details = OutputImage -  imfilter(OutputImage, gaussFilt, 'same', 'replicate');
        OutputImage = OutputImage + alpha*details;
    end;