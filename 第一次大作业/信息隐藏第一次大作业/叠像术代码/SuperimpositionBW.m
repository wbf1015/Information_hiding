function SuperimpositionBW()
%divide a .bmp image into two crypted images
%show that two images and the recovered result
origin = imread('LenaBW_256.bmp'); %原始图像
origin1 = imread('mandrilBW_256.bmp'); %分存图1
origin2 = imread('PeppersBW_256.bmp'); %分存图2

[image1,image2] = divide(origin,origin1,origin2);
figure
imshow(origin);
figure
imshow(origin1);
figure
imshow(origin2);
figure
imshow(image1);
figure
imshow(image2);
originB = merge(image1,image2);

figure
imshow(originB);
end



function [image1,image2] = divide(origin,origin1,origin2)
%init
Size=size(origin);
x=Size(1);
y=Size(2);
image1=zeros(2*x,2*y);
image1(:,:)=255;
image2=zeros(2*x,2*y);
image2(:,:)=255;

%take image1 as first
for i = 1:x
    for j = 1:y
        key = randi(4);
        son_x=1+2*(i-1);
        son_y=1+2*(j-1);
        switch key
            case 1
                if origin(i,j)==0 && origin1(i,j)==0 && origin2(i,j)==0  %黑  黑  黑
                    image1(son_x,son_y)=0;
                    image1(son_x+1,son_y)=0;
                    image1(son_x+1,son_y+1)=0;

                    image2(son_x,son_y+1)=0;
                    image2(son_x+1,son_y)=0;
                    image2(son_x+1,son_y+1)=0;
                
                elseif origin(i,j)==0 && origin1(i,j)==0 && origin2(i,j)~=0  %黑 黑 白
                    image1(son_x,son_y+1)=0;
                    image1(son_x+1,son_y)=0;
                    image1(son_x+1,son_y+1)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x,son_y+1)=0;

                elseif origin(i,j)==0 && origin1(i,j)~=0 && origin2(i,j)==0  %黑 白 黑
                    image1(son_x+1,son_y)=0;
                    image1(son_x+1,son_y+1)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x,son_y+1)=0;
                    image2(son_x+1,son_y)=0;
                
                elseif origin(i,j)==0 && origin1(i,j)~=0 && origin2(i,j)~=0  %黑 白 白
                    image1(son_x+1,son_y)=0;
                    image1(son_x+1,son_y+1)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x,son_y+1)=0;

                elseif origin(i,j)~=0 && origin1(i,j)==0 && origin2(i,j)==0  %白 黑 黑
                    image1(son_x,son_y)=0;
                    image1(son_x,son_y+1)=0;
                    image1(son_x+1,son_y)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x,son_y+1)=0;
                    image2(son_x+1,son_y)=0;

                elseif origin(i,j)~=0 && origin1(i,j)==0 && origin2(i,j)~=0  %白 黑 白
                    image1(son_x,son_y)=0;
                    image1(son_x,son_y+1)=0;
                    image1(son_x+1,son_y)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x,son_y+1)=0;

                elseif origin(i,j)~=0 && origin1(i,j)~=0 && origin2(i,j)~=0  %白 白 白
                    image1(son_x,son_y+1)=0;
                    image1(son_x+1,son_y+1)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x,son_y+1)=0;

                elseif origin(i,j)~=0 && origin1(i,j)~=0 && origin2(i,j)==0  %白 白 黑
                    image1(son_x+1,son_y)=0;
                    image1(son_x+1,son_y+1)=0;

                    image2(son_x,son_y+1)=0;
                    image2(son_x+1,son_y)=0;
                    image2(son_x+1,son_y+1)=0;
                
                end
            case 2
                if origin(i,j)==0 && origin1(i,j)==0 && origin2(i,j)==0  %黑  黑  黑
                    image1(son_x,son_y)=0;
                    image1(son_x,son_y+1)=0;
                    image1(son_x+1,son_y)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x,son_y+1)=0;
                    image2(son_x+1,son_y+1)=0;
                
                elseif origin(i,j)==0 && origin1(i,j)==0 && origin2(i,j)~=0  %黑 黑 白
                    image1(son_x,son_y)=0;
                    image1(son_x+1,son_y)=0;
                    image1(son_x+1,son_y+1)=0;

                    image2(son_x,son_y+1)=0;
                    image2(son_x+1,son_y+1)=0;

                elseif origin(i,j)==0 && origin1(i,j)~=0 && origin2(i,j)==0  %黑 白 黑
                    image1(son_x,son_y)=0;
                    image1(son_x+1,son_y)=0;

                    image2(son_x,son_y+1)=0;
                    image2(son_x+1,son_y)=0;
                    image2(son_x+1,son_y+1)=0;
                
                elseif origin(i,j)==0 && origin1(i,j)~=0 && origin2(i,j)~=0  %黑 白 白
                    image1(son_x,son_y)=0;
                    image1(son_x+1,son_y)=0;

                    image2(son_x,son_y+1)=0;
                    image2(son_x+1,son_y+1)=0;

                elseif origin(i,j)~=0 && origin1(i,j)==0 && origin2(i,j)==0  %白 黑 黑
                    image1(son_x,son_y)=0;
                    image1(son_x,son_y+1)=0;
                    image1(son_x+1,son_y+1)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x,son_y+1)=0;
                    image2(son_x+1,son_y+1)=0;

                elseif origin(i,j)~=0 && origin1(i,j)==0 && origin2(i,j)~=0  %白 黑 白
                    image1(son_x,son_y)=0;
                    image1(son_x,son_y+1)=0;
                    image1(son_x+1,son_y+1)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x+1,son_y+1)=0;

                elseif origin(i,j)~=0 && origin1(i,j)~=0 && origin2(i,j)~=0  %白 白 白
                    image1(son_x,son_y)=0;
                    image1(son_x,son_y+1)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x+1,son_y+1)=0;

                elseif origin(i,j)~=0 && origin1(i,j)~=0 && origin2(i,j)==0  %白 白 黑
                    image1(son_x,son_y)=0;
                    image1(son_x,son_y+1)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x,son_y+1)=0;
                    image2(son_x+1,son_y+1)=0;
                
                end
                
            case 3
                if origin(i,j)==0 && origin1(i,j)==0 && origin2(i,j)==0  %黑  黑  黑
                    image1(son_x,son_y+1)=0;
                    image1(son_x+1,son_y)=0;
                    image1(son_x+1,son_y+1)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x+1,son_y)=0;
                    image2(son_x+1,son_y+1)=0;
                
                elseif origin(i,j)==0 && origin1(i,j)==0 && origin2(i,j)~=0  %黑 黑 白
                    image1(son_x,son_y)=0;
                    image1(son_x,son_y+1)=0;
                    image1(son_x+1,son_y+1)=0;

                    image2(son_x+1,son_y)=0;
                    image2(son_x+1,son_y+1)=0;

                elseif origin(i,j)==0 && origin1(i,j)~=0 && origin2(i,j)==0  %黑 白 黑
                    image1(son_x,son_y)=0;
                    image1(son_x,son_y+1)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x+1,son_y)=0;
                    image2(son_x+1,son_y+1)=0;
                
                elseif origin(i,j)==0 && origin1(i,j)~=0 && origin2(i,j)~=0  %黑 白 白
                    image1(son_x,son_y)=0;
                    image1(son_x,son_y+1)=0;

                    image2(son_x+1,son_y)=0;
                    image2(son_x+1,son_y+1)=0;

                elseif origin(i,j)~=0 && origin1(i,j)==0 && origin2(i,j)==0  %白 黑 黑
                    image1(son_x,son_y+1)=0;
                    image1(son_x+1,son_y)=0;
                    image1(son_x+1,son_y+1)=0;

                    image2(son_x,son_y+1)=0;
                    image2(son_x+1,son_y)=0;
                    image2(son_x+1,son_y+1)=0;

                elseif origin(i,j)~=0 && origin1(i,j)==0 && origin2(i,j)~=0  %白 黑 白
                    image1(son_x,son_y)=0;
                    image1(son_x+1,son_y)=0;
                    image1(son_x+1,son_y+1)=0;

                    image2(son_x+1,son_y)=0;
                    image2(son_x+1,son_y+1)=0;

                elseif origin(i,j)~=0 && origin1(i,j)~=0 && origin2(i,j)~=0  %白 白 白
                    image1(son_x,son_y+1)=0;
                    image1(son_x+1,son_y)=0;

                    image2(son_x+1,son_y)=0;
                    image2(son_x+1,son_y+1)=0;

                elseif origin(i,j)~=0 && origin1(i,j)~=0 && origin2(i,j)==0  %白 白 黑
                    image1(son_x,son_y+1)=0;
                    image1(son_x+1,son_y)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x,son_y+1)=0;
                    image2(son_x+1,son_y)=0;
                
                end
                
            case 4
                if origin(i,j)==0 && origin1(i,j)==0 && origin2(i,j)==0  %黑  黑  黑
                    image1(son_x,son_y)=0;
                    image1(son_x,son_y+1)=0;
                    image1(son_x+1,son_y+1)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x,son_y+1)=0;
                    image2(son_x+1,son_y)=0;
                
                elseif origin(i,j)==0 && origin1(i,j)==0 && origin2(i,j)~=0  %黑 黑 白
                    image1(son_x,son_y)=0;
                    image1(son_x,son_y+1)=0;
                    image1(son_x+1,son_y)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x+1,son_y+1)=0;

                elseif origin(i,j)==0 && origin1(i,j)~=0 && origin2(i,j)==0  %黑 白 黑
                    image1(son_x,son_y+1)=0;
                    image1(son_x+1,son_y)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x,son_y+1)=0;
                    image2(son_x+1,son_y+1)=0;
                
                elseif origin(i,j)==0 && origin1(i,j)~=0 && origin2(i,j)~=0  %黑 白 白
                    image1(son_x,son_y+1)=0;
                    image1(son_x+1,son_y)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x+1,son_y+1)=0;

                elseif origin(i,j)~=0 && origin1(i,j)==0 && origin2(i,j)==0  %白 黑 黑
                    image1(son_x,son_y)=0;
                    image1(son_x+1,son_y)=0;
                    image1(son_x+1,son_y+1)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x+1,son_y)=0;
                    image2(son_x+1,son_y+1)=0;

                elseif origin(i,j)~=0 && origin1(i,j)==0 && origin2(i,j)~=0  %白 黑 白
                    image1(son_x,son_y+1)=0;
                    image1(son_x+1,son_y)=0;
                    image1(son_x+1,son_y+1)=0;

                    image2(son_x,son_y+1)=0;
                    image2(son_x+1,son_y+1)=0;

                elseif origin(i,j)~=0 && origin1(i,j)~=0 && origin2(i,j)~=0  %白 白 白
                    image1(son_x+1,son_y)=0;
                    image1(son_x+1,son_y+1)=0;

                    image2(son_x,son_y+1)=0;
                    image2(son_x+1,son_y+1)=0;

                elseif origin(i,j)~=0 && origin1(i,j)~=0 && origin2(i,j)==0  %白 白 黑
                    image1(son_x+1,son_y)=0;
                    image1(son_x+1,son_y+1)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x+1,son_y)=0;
                    image2(son_x+1,son_y+1)=0;
                
                end

        end
    end
end

end



function image = merge(image1,image2)
Size=size(image1);
x=Size(1);
y=Size(2);
image=zeros(x,y);
image(:,:)=255;

for i=1:x
    for j=1:y
        image(i,j)=image1(i,j)&image2(i,j);
    end
end

end