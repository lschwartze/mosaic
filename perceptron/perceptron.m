%this script needs to be run only once to train a perceptron
%these are the values computed in checkBrightness.m
%used to train the perceptron
A = [61.7029   68.6552   38.6923   27.5893   79.5736   62.3666   86.7209   24.8436   26.4612   64.6106  162.6129  170.8929  120.0067  181.5190  133.4583  180.4130  137.4942  134.1869  215.9083  195.8325
     65.9107   61.9623   45.2915   24.7417   92.1851   55.0617   89.7258   25.6958   26.4612   63.2205  144.9455  167.8926  117.8411  187.8731  148.7217  174.3092  143.3997  136.5146  209.6578  183.4163
     52.0940   69.9192   54.9366   19.6254   73.1428   51.8857   92.9205   29.1914   26.4612   53.6639  138.1790  161.4624  107.3384  197.0934  144.1143  162.8744  131.5375  134.0145  206.2094  184.8174];
dark = A(:,1:10);
light = A(:,11:end);

%actual perceptron training happens here
%use extended perceptron training - meaning that each vector will be
%extended by one value at the top in order to have a normed perceptron with
%limit at 0
trainer = zeros(4,1);
while true
    %count all vectors where trainer works
    counter = 0;
    %perceptron algorithm
    %Y0 = light
    for i=1:length(light)
        %vector extended by 255 because its the highest possible value
        y = [255;light(:,i)];
        if y'*trainer >= 0
            trainer = trainer-y; 
        else
            counter = counter+1;
        end
    end
    %Y1 = dark
    for j=1:length(dark)
        y = [255;dark(:,j)];
        if y'*trainer <= 0
            trainer = trainer+y;
        else
            counter = counter+1;
        end
    end
    %if all vectors where added to counter, perceptron has converged
    if counter==length(A)
        break;
    end
end
disp(trainer)
%RESULT: Using the vector v = [255.0000 -234.0748 -175.1421 -188.3358] a
%picture can be categorized as dark or light.
