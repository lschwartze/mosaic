%this function resizes all pictures to one uniform size
function checkSize(directory)
files = dir([directory '/' '*.jpg']);  %opens all pictures into array
s = zeros(numel(files),3);
sumLength = 0;
sumHeight = 0;
for i=1:numel(files)
    image = imread([directory '/' files(i).name]);
    %save size of current picture
    s(i,:) = size(image);
    %check if picture is vertical
    if s(i,1)> s(i,2)
       %if so, rotate and save again
       image = imrotate(image, 90);
       imwrite(image, [directory '/' files(i).name]);
       h = s(i,1);
       s(i,1) = s(i,2);
       s(i,2) = h;  
    end
    sumHeight = sumHeight + s(i,1);
    sumLength = sumLength + s(i,2);
end
%calculate average size
avgHeight = round(sumHeight/numel(files));
avgLength = round(sumLength/numel(files));
%resize to average size and save again
for i=1:numel(files)
    im = imread([directory '/' files(i).name]);
    im = imresize(im, [avgHeight, avgLength]);
    imwrite(im, [directory '/' files(i).name]);
end