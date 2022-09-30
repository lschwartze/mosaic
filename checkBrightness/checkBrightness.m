%this script needs to be run only once 
%two separable sets are created, one with light and one with dark pictures
%these sets are than used to train a perceptron that decides wether a
%picture is dark or light
files = dir('*.jpg');  %opens all pictures into array
averageColor = zeros(3,numel(files));
%loops through pictures
for i = 1:numel(files)
  filename = files(i).name;
  image = imread(filename);
  %calculate average color
  [a,b,~] = size(image);
  color = zeros(3,1);
  for j=1:a
      for k=1:b
          %needs to convert uint8 to double in order to get numbers higher
          %than 255
          IntColors = cast(squeeze(image(j,k,:)),'double');
          color = color + IntColors;
      end
  end
  color = color/(a*b);
  averageColor(:,i)=averageColor(:,i)+color;
end
disp(averageColor)
%variable averageColor is saved in file perceptron.m