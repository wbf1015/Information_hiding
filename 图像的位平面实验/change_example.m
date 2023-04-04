img = imread("newpic.bmp");
[index_row, index_col]=size(img);
figure ;
for index_layer =1:8
    layer_image=zeros (index_row, index_col) ;
    for i =1:index_row
        for j =1:index_col
            layer_image ( i , j )=bitget ( img ( i , j ) , index_layer ) ;
        end
    end
subplot (2,4 , index_layer ) ;
imshow( layer_image ) ;
title ( index_layer ) ;
end