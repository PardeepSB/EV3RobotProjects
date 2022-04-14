clc;
clear;

%A = zeros(1080,1920);
A = ones([1080,1920]);
edges = 1:480:1920;


UserInput = input('input = ');
%Wait for user to input a valid integer
while (UserInput < 0 || UserInput > 15 )
    disp('Enter integer between 0 and 15');
    UserInput = input('input = ');
end
UserInputBin = dec2bin(UserInput,4);    %Convert input to binary
UserInputBin = flip(UserInputBin);      %Flip the input


for i=1:length(edges)
    disp(UserInputBin(i));
    
    if (UserInputBin(i) == '1')
        A(:,edges(i):edges(i)+360) = 0; %Thick bar
    else
        A(:,edges(i):edges(i)+120) = 0; %Thin bar
    end
end

A = (A*0.7) + 0.3 - 0.25*rand(1080,1920);   %compress and shift matrix
                                            %then add noise
imwrite(A,'Barcode.png')                    %All values (including noise) should be within [0,1]
                                            %imwrite automatically scales by 255

%csvInput = A(540,:);
%plot(csvInput);