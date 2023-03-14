b=imread('lena.bmp');% 读入图像，像素值在b中
figure;
I=im2bw(b);
imshow(I);
title('(a)原始图像');

figure;
fa=fft2(I);% 使用fft函数进行快速傅立叶变换
ffa=fftshift(fa);% fftshift函数调整fft函数的输出顺序，将零频位置移到频谱的中心 
image(abs(ffa));
title('(b)幅度谱');

figure;
mesh(abs(ffa));% 画网格曲面图
title('(c)幅度谱的能量分布(立体视图)');

figure;
imshow(log(1+abs(ffa)), []);
title('(d)幅度谱对数变换');

figure;
fp = angle(fa);
ffp = fftshift(fp);
image(ffp);
title('(e)相位谱');

figure;
Ia = ifft2(ifftshift(log(1+abs(fa))));
imshow(abs(Ia), []);
title('(f)经过幅度谱对数变换后的反变换');

% 构造低通滤波器
h = fspecial('gaussian', size(I), 10);
% 将图像进行卷积
Ih = imfilter(I, h, 'replicate');
% 进行傅里叶变换并可视化
figure;
fh = fft2(Ih);
ffh = fftshift(fh);
image(abs(ffh));
title('(f)经过低通滤波后的幅度谱');


