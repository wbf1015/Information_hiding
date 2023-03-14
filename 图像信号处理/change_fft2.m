clear all
Picture = imread('lena.bmp');

Picture_Gray = rgb2gray(Picture);%�Ҷȴ���

Picture_FFT = fft2(Picture_Gray);%����Ҷ�任
Picture_FFT_Shift = fftshift(Picture_FFT);%��Ƶ�׽����ƶ�����0Ƶ�ʵ�������
Picture_AM_Spectrum = log(abs(Picture_FFT_Shift));%��ø���Ҷ�任�ķ�����
Picture_Phase_Specture = log(angle(Picture_FFT_Shift)*180/pi);%��ø���Ҷ�任����λ��
Picture_Restructure = ifft2(abs(Picture_FFT).*exp(j*(angle(Picture_FFT))));%˫���ع�
figure(1)
subplot(221)
imshow(Picture_Gray)
title('ԭͼ��')
subplot(222)
imshow(Picture_AM_Spectrum,[])%��ʾͼ��ķ����ף�����'[]'��Ϊ�˽���ֵ��������
title('ͼ�������')
subplot(223)
imshow(Picture_Phase_Specture,[]);
title('ͼ����λ��')
subplot(224)
imshow(Picture_Restructure,[]);
title('˫���ع�ͼ')




