function IntHiding()
    x=imread('lena.bmp'); %载体图像
    m=2011395; %要嵌入的信息
    imshow(x,[])
    [index_row,index_col]=size(x);
    WaterMarked=uint8(zeros(size(x)));
    
    for i=1:index_row
        for j=1:index_col
            if i==1 && j<=21
                tem=bitget(m,j);
                WaterMarked(i,j)=bitset(x(i,j),1,tem);
            else
                WaterMarked(i,j)=x(i,j);
            end
        end
    end
    
    imwrite(WaterMarked,'lsb_int_watermarked.bmp','bmp');
    figure;
    imshow(WaterMarked,[]);
    title("WaterMarked Image");
    WaterMark=0;
    for j=1:21
        tem=bitget(WaterMarked(1,j),1);
        WaterMark=bitset(WaterMark,j,tem);
    end
 
end

