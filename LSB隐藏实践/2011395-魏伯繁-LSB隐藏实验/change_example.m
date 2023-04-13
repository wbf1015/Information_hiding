x=imread('lena.png');%��������ͼ��
y=imresize(x, [256, 256]);%����ͼ��ֱ���Ϊ 256x256
I=rgb2gray(y);
figure;
imshow(I);
title('�Ҷ�ͼ��');

m=imread('nk.png'); %����ˮӡͼ��
mm=imresize(m, [256, 256]);
II=rgb2gray(mm);
K=imbinarize(II);
figure;
imshow(K);
title('��ֵͼ��');

[Mc,Nc]=size(K); %ȷ������ͼ��Ĵ�С
v=uint8(zeros(size(y)));%��ʼ��һ���ߺͿ���ͬ��ȫ�����
%v = zeros(size(y), 'uint8');
% v=zeros(size(y));
for i=1:Mc
    for j=1:Nc
        v(i,j)=bitset(I(i,j),1,K(i,j));%Ƕ��
    end
end

imwrite(v,'lsb_watermarked.png','png'); %����ˮӡͼ��
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