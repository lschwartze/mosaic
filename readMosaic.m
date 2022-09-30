%reads mosaic created in java script
function form = readMosaic
img = imread('paint/mosaic.png');
[rows,cols,~] = size(img);
form = strings(rows,1);
%translates picture into array with one letter for each pixel
%black pixel -> B, white Pixel -> W
for i=1:length(form)
    for j=1:cols
        if(squeeze(img(i,j,:)) > 200)
            form(i) = form(i) + "W";
        else
            form(i) = form(i) + "B";
        end
    end
end