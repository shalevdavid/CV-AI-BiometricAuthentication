% color is a 3-D vertor [ 1 1 1] for examle 
function outputImage = GenerateImageWithId(inputImg, id, color)

Text = sprintf(['ID = ' num2str(id)]);
H = vision.TextInserter(Text);
H.Color = color; % [1 1 1] for example
H.FontSize = 70;
H.Location = [25 25];

outputImage = step(H, inputImg);