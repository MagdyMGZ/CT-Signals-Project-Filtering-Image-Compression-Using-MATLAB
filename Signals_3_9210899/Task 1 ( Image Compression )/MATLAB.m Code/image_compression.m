%% Task (a)
clc
close all;
% Read and display The image input file using Relative Path.
Input_image = imread('image1.bmp');
[l,w] = size(Input_image(:,:,1));
figure, imshow(Input_image);
title("Original Input Image")
% Extract and display each one of its three color components.
[R_component,G_component,B_component] = imsplit(Input_image); 
black = zeros(l,w);
% In Gray Scale
figure 
imshow(R_component);
title('Red Component');
imwrite(R_component, 'Red Component.bmp');
figure
imshow(G_component);
title('Green Component');
imwrite(G_component, 'Green Component.bmp');
figure
imshow(B_component);
title('Blue Component');
imwrite(B_component, 'Blue Component.bmp');
% In RGB Scale
red = cat(3,R_component,black,black);
green = cat(3,black,G_component,black);
blue = cat(3,black,black,B_component);
figure
imshow(red)
imwrite(red,'Red Component RGB.bmp');
title('Red Component');
figure
imshow(green);
imwrite(green,'Green Component RGB.bmp');
title('Green Component');
figure
imshow(blue);
imwrite(blue,'Blue Component RGB.bmp');
title('Blue Component');
%% Applying DCT & Inverse DCT to 8*8 Blocks
% Task (b) & (c) & (d) Repeat for m = 1,2,3,4:
% compress the image, process each color component in blocks of 8 × 8 pixels.
% Each block will be converted into frequency domain using 2D DCT. 
% then only few coefficients are retained, while the rest will be ignored.
% Apply 2D DCT of each block having the same dimensions as the input block
decompression = cell(1,4);
compression = cell(1,4);
get_dct2 = @(block_struct) dct2(block_struct.data);
get_invdct2 = @(block_struct) idct2(block_struct.data);
mask = zeros(8);
R_DCT = blockproc(R_component,[8 8],get_dct2);
G_DCT = blockproc(G_component,[8 8],get_dct2);
B_DCT = blockproc(B_component,[8 8],get_dct2);
for m = 1:4
    mask(1:m,1:m) = 1;
    temporary = @(block_struct) block_struct.data.*mask;
    % Control the DCT Coefficient Outputs
    R_NEW = blockproc(R_DCT,[8 8],temporary);
    G_NEW = blockproc(G_DCT,[8 8],temporary);
    B_NEW = blockproc(B_DCT,[8 8],temporary);
    temp = @(block_struct) block_struct.data(1:m,1:m);
    R_compressed = blockproc(R_DCT,[8 8],temp);
    G_compressed = blockproc(G_DCT,[8 8],temp);
    B_compressed = blockproc(B_DCT,[8 8],temp);
    R_compressed_INVDCT = blockproc(R_compressed,[m m],get_invdct2);
    G_compressed_INVDCT = blockproc(G_compressed,[m m],get_invdct2);
    B_compressed_INVDCT = blockproc(B_compressed,[m m],get_invdct2);
    compressed_image = uint8(cat(3,R_compressed_INVDCT,G_compressed_INVDCT,B_compressed_INVDCT));
    compression{1,m} = compressed_image;
    R_INVDCT = blockproc(R_NEW,[8 8],get_invdct2);
    G_INVDCT = blockproc(G_NEW,[8 8],get_invdct2);
    B_INVDCT = blockproc(B_NEW,[8 8],get_invdct2);
    decompression{1,m} = uint8(cat(3,R_INVDCT,G_INVDCT,B_INVDCT));
end
%% Task (e) & Task (f) Calculation and Plotting PSNR (Peak signal - to Noise Ratio)
peaksnr = ones(1,4);
Remaining = 0;
for m = 1:4
    imwrite(compression{1,m},strcat('compressed image at m =  ', num2str(m),'.bmp'));
    imwrite(decompression{1,m},strcat('decompressed image at m =  ', num2str(m),'.bmp'));
    figure
    imshow(compression{1,m})
    title(strcat('compressed image at m =  ', num2str(m)));
    figure
    imshow(decompression{1,m})
    title(strcat('decompressed image at m =  ', num2str(m)));
    peaksnr(m) = psnr(uint8(decompression{1,m}),uint8(Input_image));
end
fprintf("PSNR for m = 1, 2, 3, 4 Values are : \n");
disp(peaksnr);
figure
plot(1:4,peaksnr)
title('PSNR Graph')
xlabel('m - axis')
ylabel('PSNR - axis')
figure
stem(1:4,peaksnr)
title('PSNR Graph')
xlabel('m - axis')
ylabel('PSNR - axis')