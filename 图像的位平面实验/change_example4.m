img = imread('lena.bmp');
message = imread('sample.png');
message = imresize(message, [size(img, 1), size(img, 2)]);
% 将彩色图像转换为灰度图像
gray_image = rgb2gray(message);
% 阈值化灰度图像，将其转换为黑白图像
black_white_image = imbinarize(gray_image);
message = black_white_image;

% resized_image = imresize(imread('lena.bmp'), [256 256], 'bicubic');
image = img;
for i = 1:size(img, 1)
    for j = 1:size(img, 2)
        image ( i , j )=bitset( image ( i , j ) ,1 , message ( i , j ) ) ;
    end
end
figure;
imshow(image);
imwrite(image, 'hide_image.png', 'png');

m = size(img, 1);
n = size(img, 2);
x=zeros (m, n) ;
for i =1:m
    for j =1:n
        x( i , j )=bitget ( image ( i , j ) ,1) ;
    end
end
figure ;
imshow(x) ;

