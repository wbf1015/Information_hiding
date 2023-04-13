
function change_example2()
    x=imread('lena.bmp'); %载体图像
    m=imread('nk.bmp'); %水印图像
    y=imresize(x, [256, 256]);%调整图像分辨率为 256x256
    x=rgb2gray(y);%转换成灰度图像
    
    mm=imresize(m, [256, 256]);%调整图像分辨率为 256x256
    II=rgb2gray(mm);%转换成灰度图像
    m=imbinarize(II);%转换成二值图像
    figure;
    imshow(x,[]);%展示灰度图像x
    figure;
    imshow(m,[]);%展示二值图像m
    
    [index_row,index_col]=size(x);
    AddPrint=uint8(zeros(size(x)));
    
    for i=1:index_row
        for j=1:index_col
            AddPrint(i,j)=bitset(x(i,j),1,m(i,j));
        end
    end
    
    imwrite(AddPrint,'lsb_watermarked.bmp','bmp');
    figure;
    imshow(AddPrint,[]);
    title("AddPrint Image");
    
    [index_row2,index_col2]=size(AddPrint);
    Print=uint8(zeros(size(AddPrint)));

    for i=1:index_row2
        for j=1:index_col2
            Print(i,j)=bitget(AddPrint(i,j),1);
        end
    end

    figure;
    imshow(Print,[]);
    title("Print");
    
end