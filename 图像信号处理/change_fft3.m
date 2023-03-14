% 图像的双谱重构是指将图像的功率谱和相位谱进行分离处理，再将其重新组合得到一张新的图像。在Matlab中，可以通过以下步骤实现图像的双谱重构：
I = imread('lena.bmp');
I = rgb2gray(I);
F = fft2(I);
A = abs(F);
P = angle(F);
AL = log(1+A);
AL = fftshift(AL);
F2 = exp(AL).*exp(1i*P);
I2 = real(ifft2(F2));
imshowpair(I,I2,'montage')
title('Original Image (left) and Reconstructed Image (right)')

