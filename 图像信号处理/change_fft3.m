% ͼ���˫���ع���ָ��ͼ��Ĺ����׺���λ�׽��з��봦���ٽ���������ϵõ�һ���µ�ͼ����Matlab�У�����ͨ�����²���ʵ��ͼ���˫���ع���
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

