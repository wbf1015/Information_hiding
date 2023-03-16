% 读入图像
b = imread('test.bmp');
a = rgb2gray(b);

% 进行二级小波分解
[ca1,ch1,cv1,cd1] = dwt2(a,'db4');
[ca2,ch2,cv2,cd2] = dwt2(ca1,'db4');

% 绘制分解后的各个子带图像
nbcol = size(a, 1);
cod_ca2 = wcodemat(ca2,nbcol);
cod_ch2 = wcodemat(ch2,nbcol);
cod_cv2 = wcodemat(cv2,nbcol);
cod_cd2 = wcodemat(cd2,nbcol);
cod_ca1 = wcodemat(ca1,nbcol);
cod_ch1 = wcodemat(ch1,nbcol);
cod_cv1 = wcodemat(cv1,nbcol);
cod_cd1 = wcodemat(cd1,nbcol);
figure;
subplot(2,4,1), imshow(cod_ca2,[]), title('(a)LL2');
subplot(2,4,2), imshow(cod_ch2,[]), title('(b)LH2');
subplot(2,4,3), imshow(cod_cv2,[]), title('(c)HL2');
subplot(2,4,4), imshow(cod_cd2,[]), title('(d)HH2');
subplot(2,4,5), imshow(cod_ca1,[]), title('(e)LL1');
subplot(2,4,6), imshow(cod_ch1,[]), title('(f)LH1');
subplot(2,4,7), imshow(cod_cv1,[]), title('(g)HL1');
subplot(2,4,8), imshow(cod_cd1,[]), title('(h)HH1');
