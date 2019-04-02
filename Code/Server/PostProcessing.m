    function [BW] = PostProcessing(BW)
        
        BW = bwmorph(BW, 'clean');
        BW = bwmorph(BW, 'bridge');
        BW = bwmorph(BW, 'majority');
        BW = bwmorph(BW, 'close');
        BW = bwmorph(BW, 'fill'); % Optional
        BW = imfill(BW,'holes');% Optional
        
        CC = bwconncomp(BW);
        Stats = regionprops(CC, 'Area', 'Eccentricity');
        idx = find([Stats.Area]>15);
        BW = ismember(labelmatrix(CC), idx);
        
        % Remove noise by filling holes in background (closing backgroung).
        % Assuming all ROI's of foregroung cross the borders of the image.
        % BW = 1 - imfill(1-BW,'holes');