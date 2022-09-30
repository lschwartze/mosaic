%this function is based on checkbrightness method, returns wether an image
%is dark or light
function bright = separateBrightness(filename, directory)
image = imread(filename);
% [a,b,~] = size(image);
% color = zeros(3,1);
% for j=1:a
%     for k=1:b
%         %needs to convert uint8 to double in order to get numbers higher
%         %than 255
%         IntColors = cast(squeeze(image(j,k,:)),'double');
%         color = color + IntColors;
%     end
% end
% color = color/(a*b);
color = [mean(image(:,:,1),'all') mean(image(:,:,2),'all') mean(image(:,:,3),'all')]';
color = [255; color];
%vector calculated by perceptron
threshold = [255.0000 -234.0748 -175.1421 -188.3358];
%perceptron decides wether picture is light or dark
if threshold*color < 0
    bright = "light";
else
    bright = "dark";
end
file = [directory '/brightnessDatabase.txt'];
file = fopen(file, 'a');
fprintf(file, "%s\n%s\n", filename, bright);
fclose(file);