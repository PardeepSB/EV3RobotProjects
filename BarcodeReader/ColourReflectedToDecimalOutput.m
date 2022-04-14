% Code that reads color value using cutoff point of 100
% to determine black or white

clc;
clear;

%Read csv file
datatable = readtable('exp_1_data.csv', 'ReadVariableNames', false);  %or true if there is a header
numRows = height(datatable);
RNG = [1 2 numRows 2];
csvInput = csvread('exp_1_data.csv',1,2,RNG);

%colourThreshold (70 virtual, 45 Physical)
colourThresh = 70;

%temp input
%barcodeMatrix = imread('Barcode.png');
%csvInput = barcodeMatrix(540,:);



binaryInput = zeros(1,length(csvInput));
%Convert csv file noise to binary black or white
for i=1:length(csvInput)
    if (csvInput(i) > colourThresh)
        binaryInput(i) = 1;
    end
end

plot(binaryInput);

%Measure the length of each black bar
mesBlackLength = zeros(1,4);    %expect to see 4 bars
mesWhiteSpace = zeros(1,4);
j = 1;
firstBarDetected = 0;


%Data always starts on black (black = 0)

for i=2:length(binaryInput)
    if (binaryInput(i) == 0)    %measure length of each black bar
       mesBlackLength(j) = mesBlackLength(j)+1;
       %firstBarDetected = 1;
    end
    
    if ((binaryInput(i) == 1))
        %start counting white space after the first black bar
        mesWhiteSpace(j) = mesWhiteSpace(j)+1;
    end
    
    if (binaryInput(i-1) > binaryInput(i) )  %Detect falling edge
        %if prev value = 1 and current value = 0
        
        j = j+1;  %next bar
    end
end


%Compare lengths
%needs some tolerance
relativeWidth = zeros(1,4);
binaryOutput =  zeros(1,4);
for i=1:length(mesBlackLength)
    relativeWidth(i) = mesBlackLength(i)/(mesBlackLength(i) + mesWhiteSpace(i));
    
    if relativeWidth(i) < 0.45
        binaryOutput(i) = 0;
    else
        binaryOutput(i) = 1;
    end
end

f="";
for i=1:4
    %disp(binaryOutput(i));
    f = strcat(f,num2str(binaryOutput(i)));
end
%binaryOutput = flip(binaryOutput);
outputString = char(binaryOutput + 48); %ASCII code; need to add 48
outputNumber = bin2dec(reverse(outputString));
fprintf("Plessy Number %s\n", f);
fprintf("Binary Number %s\n", reverse(f)); 
fprintf("Output: %g\n", outputNumber);




