%run this script to create a Collage with pictures in this directory
%folder name with necessary pictures is given as user input
searchFolder = true;
prompt = "input the name of your folder: ";
directory = input(prompt, "s");
path = [directory '/*.jpg'];
database = [directory '/brightnessDatabase.txt'];

%request input until name of existing folder is given
while searchFolder
    if not(isfolder(directory))
        disp("folder does not exist");
        directory = input(prompt, "s");
        path = [directory '/*.jpg'];
    else
        searchFolder = false;
    end
end

prompt = "artificially increase contrast? \nNote: this might compromise the individual pictures [y/n]: ";
while true
    contrast = input(prompt, "s");
    if contrast == "n" || contrast == "y"
        break; 
    else
        prompt = "me fail english? that's unpossible. [y/n] ";
    end
end

disp("reshaping pictures")
checkSize(directory);
files = dir(path);  %opens all pictures into array
%each of these arrays will store the name of all dark and light pictures
Light = [];
Dark = [];

disp("attempts to create collage with given pictures")

%loops through pictures
for i = 1:numel(files)
  filename = files(i).name;
  %needs to convert char array filename to string to store it in an array
  filename = [directory '/' filename];
  filename = convertCharsToStrings(filename);
  
  %checks if file exists
  fileID = fopen(database, 'a');
  fclose(fileID);
  
  fprintf("check if picture %s is in database...\n", filename);
  %checks if file is already in database
  fileID = fopen(database,'r');
  A = textscan(fileID,'%s');
  fclose(fileID);
  n = size(A{:});
  index = 0;
  for j = 1:n
      if strcmp(A{:}(j),filename)
          index = j;
      end
  end
  
  %index = 0 shows that file is not in database.
  if index == 0
    fprintf("file is not in database - calculating brightness of picture %s...\n", filename);
    bright = separateBrightness(filename, directory);
  %index isn't 0, means image is in database, search if it is light or dark
  else
    fprintf("%s is in database\n", filename);
    fileID = fopen(database,'r');
    %reads line beneath name of image, brightness is stored here
    for k=1:index+1
        line = fgetl(fileID);
    end
    bright = line;
    fclose(fileID);
  end
  
  if bright == "light"
     if contrast == "y"
         adjustContrast(files(i).name, directory, "light"); 
         Light = [Light; convertCharsToStrings([directory '/adjustedLight/' files(i).name])];
     else
         Light = [Light; filename];
     end
  else
      %potentially drive up the contrast
     if contrast == "y"
         adjustContrast(files(i).name, directory, "dark"); 
         %altered pictures will be stored in different dir
         Dark = [Dark; convertCharsToStrings([directory '/adjustedDark/' files(i).name])];
     else
         Dark = [Dark; filename];
     end
  end

end
createCollage(Light, Dark)