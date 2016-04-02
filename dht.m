function [ d ] = dht( f )
% dht can be computed as the difference between the Re and Im parts of DFT.
% Then it is scaled by the number of coefficients, which for 8x8 is 64.
im2fft = fft2(f);
d = (real(im2fft) - imag(im2fft))/64.0;

end

