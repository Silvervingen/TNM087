%%Preparation LAB2 BoB
% Josefine Klintberg

%% Reading image
%
% Read in the image
I = imread('TestPattern.tif');
I = im2double(I);

%% Testing different box filters
% %Create box kernel 9x9
% B = ones(21)/(21^2);
% 
% %Create id. matrix
% d = zeros(21);
% d(11, 11) = 1; 
% 
% %Create a highpass filter d - B
% hp = d - B;
% 
% %Filter the image with box kernel
% Image4 = imfilter(I, hp, 'Replicate');
% 
% %Unsharp masking
% Image5 = I + Image4;
% 
% imshow(Image5)
% %imshowpair(I, Image1, 'Montage')
% imwrite(Image5,'Image5.png')

%% Testing Sober filters

%Filtering in x and y direction
Sob_x = [-1 -2 -1; 0 0 0; 1 2 1]
Sob_y = [-1 0 1; -2 0 2; -1 0 1]
Image6 = imfilter(I, Sob_x);
Image7 = imfilter(I, Sob_y);

imshow(Image7)
imwrite(Image7, 'Image7.png')

%Gradient image
Image8 = (Image6.^2 + Image7.^2).^(0.5);

imshow(Image8)
imwrite(Image8, 'Image8.png')

