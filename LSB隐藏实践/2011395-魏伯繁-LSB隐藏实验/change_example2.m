
function change_example2()
    x=imread('lena.bmp'); %����ͼ��
    m=imread('nk.bmp'); %ˮӡͼ��
    y=imresize(x, [256, 256]);%����ͼ��ֱ���Ϊ 256x256
    x=rgb2gray(y);%ת���ɻҶ�ͼ��
    
    mm=imresize(m, [256, 256]);%����ͼ��ֱ���Ϊ 256x256
    II=rgb2gray(mm);%ת���ɻҶ�ͼ��
    m=imbinarize(II);%ת���ɶ�ֵͼ��
    figure;
    imshow(x,[]);%չʾ�Ҷ�ͼ��x
    figure;
    imshow(m,[]);%չʾ��ֵͼ��m
    
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