image=imread("Lena.bmp");
wm=imread("lion.bmp");

w=8;
s=256;
blocks=32;
new_image=zeros(s);

wm=imbinarize(wm);

image=imresize(image,[s,s]);
wm=imresize(~wm,[blocks,blocks]);

image=double(image)/s;
wm=im2double(wm);



%嵌入水印 逐块扫描
for i = 1:blocks
    for j = 1:blocks
        x=(i-1)*w+1;
        y=(j-1)*w+1;
        cb=image(x:x+w-1,y:y+w-1);
        cb=dct2(cb);
        if wm(i,j)==0
            a=-1;
        else
            a=1;
        end
        cb(1,1)=cb(1,1)*(1+a*0.001);
        cb=idct2(cb);
        new_image(x:x+w-1,y:y+w-1)=cb;
    end
end

%提取水印 逐块进行
extract=zeros(32,32);
for i = 1:blocks
    for j = 1:blocks
        x=(i-1)*w+1;
        y=(j-1)*w+1;
        if new_image(x,y)>image(x,y)
            extract(i,j)=1;
        else
            extract(i,j)=0;  
        end
    end
    
end

figure;
subplot(221); imshow(image); title("原始图像");
subplot(222); imshow(wm); title("水印图像");
subplot(223); imshow(new_image,[]); title("嵌入水印");
subplot(224); imshow(extract); title("提取水印");