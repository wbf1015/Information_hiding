function HideAndExtract()
    x=imread ('Lena.bmp'); %载体图像
    % y=imread ('lion.bmp'); %秘密信息图像是灰度图像，长宽均为载体图像的一半?
    % y=imbinarize(y);
    % [row_size, col_size]= size(y); 
    
    y = imread('nankai.bmp');
    % 获取x的大小
    [row_size, col_size, ~] = size(x);

    % 将y resize为x的大小的一半
    y_resized = imresize(y, [row_size/2, col_size/2]);

    % 将y转换为灰度图像
    y = rgb2gray(y_resized);
    y=imbinarize(y);
    [row_size, col_size]= size(y); 
    
    subplot(2, 2, 1);
    imshow(x) ; title('原始图像'); 
    
    subplot(2, 2, 2); 
    imshow(y) ; title('水印图像'); 

    x=Embed(x,row_size,col_size,y);
    subplot(2, 2, 3); 
    imshow(x ,[]) ; title('伪装图像'); 

    t=Fetch();
    subplot(2,2,4);
    imshow(t,[]); title("提取出的水印图像");
end


function out = checksum (x, index_row, index_col) 
   %计算特定一维向量的第m个区域的最低位的校验和
   temp= zeros(1, 4);
   temp(1) = bitget(x(2*index_row-1,2*index_col-1), 1); 
   temp(2) = bitget(x(2*index_row-1,2*index_col), 1); 
   temp(3) = bitget(x(2*index_row, 2*index_col-1), 1); 
   temp(4) = bitget(x(2*index_row, 2*index_col ), 1); 
   out=rem(sum(temp), 2); 
end 

function result=Embed(x,row_size,col_size,y)
    for index_row =1:row_size 
        for index_col =1:col_size 
            if checksum(x, index_row, index_col) ~= y(index_row, index_col) %需要反转一位? 
                random= int8(rand()*3); 
                switch random  %任意反转一位
 				    case 0
 					    x(2*index_row-1,2*index_col-1)= bitset(x(2*index_row-1,2*index_col-1), 1, ~ bitget(x(2*index_row-1,2*index_col-1), 1)); 
				    case 1 
 					    x(2*index_row-1,2*index_col)= bitset(x(2*index_row-1,2*index_col) , 1 , ~ bitget(x(2*index_row-1,2*index_col), 1)); 
				    case 2 
 					    x(2*index_row, 2*index_col-1)= bitset(x(2*index_row, 2*index_col-1) ,1 ,~ bitget(x(2*index_row , 2*index_col-1) , 1)); 
                    case 3 
 					    x(2*index_row , 2*index_col)= bitset(x(2*index_row , 2*index_col) , 1 , ~ bitget(x(2*index_row , 2*index_col) , 1)); 
                end 
            end 
        end 
    end 
    imwrite(x , 'watermarkedImage.bmp'); 
    result=x;
end


function out=Fetch()
    c=imread('watermarkedImage.bmp'); 
    [row_size, col_size]= size(c); 
    secret = zeros(row_size/2 , col_size/2); 
    for index_row =1:row_size/2
        for index_col =1: col_size/2
            secret(index_row, index_col)= checksum(c, index_row, index_col); 
        end 
    end 
    out=secret;
end