b=imread('lena.bmp');% ����ͼ������ֵ��b��
figure;
I=im2bw(b);
imshow(I);
title('(a)ԭʼͼ��');

figure;
fa=fft2(I);% ʹ��fft�������п��ٸ���Ҷ�任
ffa=fftshift(fa);% fftshift��������fft���������˳�򣬽���Ƶλ���Ƶ�Ƶ�׵����� 
image(abs(ffa));
title('(b)������');

figure;
mesh(abs(ffa));% ����������ͼ
title('(c)�����׵������ֲ�(������ͼ)');

figure;
imshow(log(1+abs(ffa)), []);
title('(d)�����׶����任');

figure;
fp = angle(fa);
ffp = fftshift(fp);
image(ffp);
title('(e)��λ��');

figure;
Ia = ifft2(ifftshift(log(1+abs(fa))));
imshow(abs(Ia), []);
title('(f)���������׶����任��ķ��任');

% �����ͨ�˲���
h = fspecial('gaussian', size(I), 10);
% ��ͼ����о��
Ih = imfilter(I, h, 'replicate');
% ���и���Ҷ�任�����ӻ�
figure;
fh = fft2(Ih);
ffh = fftshift(fh);
image(abs(ffh));
title('(f)������ͨ�˲���ķ�����');


