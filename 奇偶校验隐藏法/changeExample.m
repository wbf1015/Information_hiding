function HideAndExtract()
    x=imread ('Lena.bmp'); %����ͼ��
    % y=imread ('lion.bmp'); %������Ϣͼ���ǻҶ�ͼ�񣬳����Ϊ����ͼ���һ��?
    % y=imbinarize(y);
    % [row_size, col_size]= size(y); 
    
    y = imread('nankai.bmp');
    % ��ȡx�Ĵ�С
    [row_size, col_size, ~] = size(x);

    % ��y resizeΪx�Ĵ�С��һ��
    y_resized = imresize(y, [row_size/2, col_size/2]);

    % ��yת��Ϊ�Ҷ�ͼ��
    y = rgb2gray(y_resized);
    y=imbinarize(y);
    [row_size, col_size]= size(y); 
    
    subplot(2, 2, 1);
    imshow(x) ; title('ԭʼͼ��'); 
    
    subplot(2, 2, 2); 
    imshow(y) ; title('ˮӡͼ��'); 

    x=Embed(x,row_size,col_size,y);
    subplot(2, 2, 3); 
    imshow(x ,[]) ; title('αװͼ��'); 

    t=Fetch();
    subplot(2,2,4);
    imshow(t,[]); title("��ȡ����ˮӡͼ��");
end


function out = checksum (x, index_row, index_col) 
   %�����ض�һά�����ĵ�m����������λ��У���
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
            if checksum(x, index_row, index_col) ~= y(index_row, index_col) %��Ҫ��תһλ? 
                random= int8(rand()*3); 
                switch random  %���ⷴתһλ
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