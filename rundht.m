% Question 9.8 from the text book

function ex9_8

cimage = input('Enter name of image: ','s');
im = imread(cimage);


% reconstruct with 4 coefficients
[im_r,N,psnr] = coeff9_8(im,4);
figure(1)
imshow(uint8(im_r))
title(sprintf('4 coefficients (PSNR = %.4f, %d nonzero coefficients in total)',...
    psnr, N))
print -deps2 lena_4

% reconstruct with 8 coefficients
[im_r,N,psnr] = coeff9_8(im,8);
figure(2)
imshow(uint8(im_r))
title(sprintf('8 coefficients (PSNR = %.4f, %d nonzero coefficients in total)',...
    psnr, N))
print -deps2 lena_8

% reconstruct with 16 coefficients
[im_r,N,psnr] = coeff9_8(im,16);
figure(3)
imshow(uint8(im_r))
title(sprintf('16 coefficients (PSNR = %.4f, %d nonzero coefficients in total)',...
    psnr, N))
print -deps2 lena_16

% reconstruct with 32 coefficients
[im_r,N,psnr] = coeff9_8(im,32);
figure(4)
imshow(uint8(im_r))
title(sprintf('32 coefficients (PSNR = %.4f, %d nonzero coefficients in total)',...
    psnr, N))
% 32*prod(size(im))/64)
print -deps2 lena_32

% Compute the reconstructed image with different numbers of coefficients
% input:     im -- original image
%             k -- number of retained coefficients
% output:  im_r -- reconstructed image
%             N -- number of nonzero coefficients
%          psnr -- psnr of the reconstructed image

function [im_r,N,psnr] = coeff9_8(im,k)

im = double(im);

im_c = blkproc(im,[8,8],'round(dht(x).*P1)',zigzag(8));
N = length(find(im_c ~= 0));
im_r = blkproc(im_c,[8,8],'64.*dht(x)');
psnr = 10*log10(255*255/mean(mean((im - im_r).^2)));




% vector a --> square matrix b (sizeb-by-sizeb) in zigzag order
function b = zigzag(sizeb)
dhtcoeff = [1 9 2 3 10 17 25 18];
%dhtcoeff_2 = dhtcoeff(1:sizeb);
b = zeros(8,8);
b(dhtcoeff)=1;

