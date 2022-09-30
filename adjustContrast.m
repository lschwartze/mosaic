function adjustContrast(filename, dirAd, brightness)
if brightness == "dark"
    disp("adjusting contrast...")
    %check if extra dir already exists, if not create it
    if ~exist(strcat(dirAd, "/adjustedDark"), 'dir')
        mkdir(strcat(dirAd, "/adjustedDark"));
    end

    img = imread(strcat(dirAd, "/", filename));
    [a,b,~] = size(img);

    fprintf("working on %s...\n", filename);
    %loops through all the pixels of the picture and subtracts 25 from each 
    %component of the RGB values if possible.
    for i=1:a
        for j=1:b
            for k=1:3
                if img(i,j,k)>=25
                    img(i,j,k) = img(i,j,k)-25;
                else
                    img(i,j,k) = 0;
                end
            end
        end
    end
    %new image will be stored in extra dir in order to keep the originals
    imwrite(img,strcat(dirAd, "/adjustedDark/", filename));
else
    disp("adjusting contrast...")
    %check if extra dir already exists, if not create it
    if ~exist(strcat(dirAd, "/adjustedLight"), 'dir')
        mkdir(strcat(dirAd, "/adjustedLight"));
    end

    img = imread(strcat(dirAd, "/", filename));
    [a,b,~] = size(img);

    fprintf("working on %s...\n", filename);
    %loops through all the pixels of the picture and adds 25 to each 
    %component of the RGB values if possible.
    for i=1:a
        for j=1:b
            for k=1:3
                if img(i,j,k)<=230
                    img(i,j,k) = img(i,j,k)+25;
                else
                    img(i,j,k) = 255;
                end
            end
        end
    end
    %new image will be stored in extra dir in order to keep the originals
    imwrite(img,strcat(dirAd, "/adjustedLight/", filename));
end