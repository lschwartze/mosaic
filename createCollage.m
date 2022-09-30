function createCollage(Light, Dark)
disp("creating each unique row separately...")
form = readMosaic;
disp("creating row 1...");
P = Row(1,Light,Dark);

for i=2:length(form)
    fprintf("creating row %d...\n", i);
    P = [P; Row(i,Light,Dark)]; 
end
imshow(P);

prompt = "save a high resolution copy of this image?\nNote: this process might take a while [y/n]: ";
while true
    copy = input(prompt, "s");
    if copy == "n"
        break; 
    elseif copy == "y"
        ax = gca;
        exportgraphics(ax, "collage.png", 'Resolution', 1500); 
        disp("saved as collage.png");
        break;
    else
        prompt = "me fail english? that's unpossible. [y/n] ";
    end
end