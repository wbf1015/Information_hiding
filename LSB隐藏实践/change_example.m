x=imread('lena.png');%读入载体图像
y=imresize(x, [256, 256]);%调整图像分辨率为 256x256
I=rgb2gray(y);
figure;
imshow(I);
title('灰度图像');

m=imread('nk.png'); %读入水印图像
mm=imresize(m, [256, 256]);
II=rgb2gray(mm);
K=imbinarize(II);
figure;
imshow(K);
title('二值图像');

[Mc,Nc]=size(K); %确定载体图像的大小
v=uint8(zeros(size(y)));%初始化一个高和宽相同的全零矩阵
%v = zeros(size(y), 'uint8');
% v=zeros(size(y));
for i=1:Mc
    for j=1:Nc
        v(i,j)=bitset(I(i,j),1,K(i,j));%嵌入
    end
end

imwrite(v,'lsb_watermarked.png','png'); %保存水印图像
figure;
imshow(v,[]);
title('Watermarked Image');

s=imread('lsb_watermarked.png');
[Mw,Nw]=size(s);
w=zeros(size(s));
for i=1:Mw
    for j=1:Nw
        w(i,j)=bitget(s(i,j),1);
    end
end
figure;
imshow(w,[]);
title('Recovered Watermark');