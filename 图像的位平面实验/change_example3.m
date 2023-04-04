clc; clear; close all;
% 读取图像
img = imread('newpic.bmp');
temp_image = img;
[index_row, index_col] = size(img);
figure;
for index_layer = 1:8
    for i = 1:index_row
        for j = 1:index_col
            temp_image(i , j) = bitset(temp_image(i , j), index_layer, 0);
        end
    end
    subplot (2, 4, index_layer);
    imshow(temp_image);
    title(['去掉前 ', num2str(index_layer), '层图像']);
end
