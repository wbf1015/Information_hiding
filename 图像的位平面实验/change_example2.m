clc; clear; close all;
% 读取图像
img = imread('newpic.bmp');
[index_row, index_col] = size(img);
temp_image = img;
zero_image = zeros(index_row, index_col);
for layer_index = 1:8
    for i = 1:index_row
        for j = 1:index_col
            zero_image(i, j) = bitset(zero_image(i, j), layer_index, bitget(img(i, j), layer_index));
            temp_image(i, j) = bitset(temp_image(i, j), layer_index, 0);
        end
    end
    figure;
    subplot(1, 2, 1); imshow(zero_image, []); title(['前 ', num2str(layer_index), ' 层 图 像']);
    subplot(1, 2, 2); imshow(temp_image, []); title(['去 掉前 ', num2str(layer_index), ' 层 图像']);
end

