% Question 9.8 from the text book



function rundht

cimage = input('Enter name of image: ','s');
im = imread(cimage);

MSE = zeros(2,4);
PSNR = zeros(2,4);

% reconstruct with 4 coefficients
[im_r,N,psnr,mse] = coeff(im,4);
imshow(uint8(im_r))
title(sprintf('4 coefficients (PSNR = %.4f, %d nonzero coefficients in total)',...
    psnr, N))
print -deps2 lena_4
saveas(gcf, 'DHT_4.jpg');
MSE(:,1) = [4 mse];
PSNR(:,1) = [4 psnr];


% reconstruct with 8 coefficients
[im_r,N,psnr,mse] = coeff(im,8);
figure(2)
imshow(uint8(im_r))
title(sprintf('8 coefficients (PSNR = %.4f, %d nonzero coefficients in total)',...
    psnr, N))
print -deps2 lena_8
saveas(gcf, 'DHT_8.jpg');
MSE(:,2) = [8 mse];
PSNR(:,2) = [8 psnr];

% reconstruct with 16 coefficients
[im_r,N,psnr,mse] = coeff(im,16);
figure(3)
imshow(uint8(im_r))
title(sprintf('16 coefficients (PSNR = %.4f, %d nonzero coefficients in total)',...
    psnr, N))
print -deps2 lena_16
saveas(gcf, 'DHT_16.jpg');
MSE(:,3) = [16 mse];
PSNR(:,3) = [16 psnr];

% reconstruct with 32 coefficients
[im_r,N,psnr,mse] = coeff(im,32);
figure(4)
imshow(uint8(im_r))
title(sprintf('32 coefficients (PSNR = %.4f, %d nonzero coefficients in total)',...
    psnr, N))
% 32*prod(size(im))/64)
print -deps2 lena_32
saveas(gcf, 'DHT_32.jpg');
MSE(:,4) = [32 mse];
PSNR(:,4) = [32 psnr];

figure;
plot(MSE(1,:), MSE(2,:));
title('MSE vs # of coefficients');
saveas(gcf, 'DHT_MSE.jpg')
figure;
plot(PSNR(1,:), PSNR(2,:));
title('PSNR vs # of coefficients');
saveas(gcf, 'DHT_PSNR.jpg')
% Compute the reconstructed image with different numbers of coefficients
% input:     im -- original image
%             k -- number of retained coefficients
% output:  im_r -- reconstructed image
%             N -- number of nonzero coefficients
%          psnr -- psnr of the reconstructed image

function [im_r,N,psnr,mse] = coeff(im,k)

im = double(im);

im_c = blkproc(im,[8,8],'dht(x).*P1',coeff_indx(k));
N = length(find(im_c ~= 0));
im_r = blkproc(im_c,[8,8],'64.*dht(x)');
psnr = 10*log10(255*255/mean(mean((im - im_r).^2)));
se = (im-im_r).^2;
mse = sum(se(:))/64;



% Compute a binary matrix following the scanning order of DHT
function b = coeff_indx(sizeb)

% shortcut to convert to linear index
i = @(x,y) sub2ind([8 8], x, y);


assert(sizeb <= 32);
% only need the first 32 coeffs max
%             1      2      3      4      5     6       7      8
dhtcoeff = [i(1,1) i(1,2) i(2,1) i(1,3) i(3,1) i(1,4) i(4,1) i(1,5)
%             9      10    11     12       13    14    15       16
            i(5,1) i(1,6) i(6,1) i(1,7) i(7,1) i(1,8) i(8,1) i(2,2) 
%             17     18    19     20      21     22      23      24
            i(2,3) i(3,2) i(2,4) i(4,2) i(2,5) i(5,2)  i(2,6) i(6,2)
%             25    26      27     28    29     30      31    32
            i(2,7) i(7,2) i(2,8) i(8,2) i(3,3) i(3,4) i(4,3) i(3,5)];

%truncate by how many we want to keep
dhtcoeff_trunc = dhtcoeff(1:sizeb);

% zeros everywehere
b = zeros(8,8);

%save what we want to keep
b(dhtcoeff_trunc)=1;




