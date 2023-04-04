image = imread('hide_image.png');
x=zeros (m, n) ;
for i =1:m
    for j =1:n
        x( i , j )=bitget ( image ( i , j ) ,1) ;
    end
end
figure ;
imshow(x , [ ] ) ;
