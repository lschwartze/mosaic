function R = Row(index, W, B)
%each string represents one row of the final collage, used multiple times
%have to be stored as strings, because matlab concatenates char arrays 
form = readMosaic;
Light = [];
Dark = [];
cntW = 0;
cntB = 0;
R = [];
%can't use strings as arrays, therefore convert string to char array
text = convertStringsToChars(form(index));
%count number of dark and light pixels
for j=1:length(text)
    if text(j) == "W"
        cntW = cntW+1;
    else
        cntB = cntB+1;
    end
end
%creates array for light and dark pictures
for i=1:cntW
    Light = [Light W(randsample(length(W),1))];
end
for i=1:cntB
    Dark = [Dark B(randsample(length(B),1))];
end
%reads string again, creates row of final picture with pixels at correct
%place
for k=1:length(text)
    if text(k) == 'W'
        R = [R imread(Light(cntW))];
        cntW = cntW-1;
    else
        R = [R imread(Dark(cntB))];
        cntB = cntB-1;
    end
end
end