function HideAndExtract()
    x=imread ('Lena.bmp'); %载体图像是灰度图像?
    y=imread ('lion.bmp');  %秘密信息图像是灰度图像，长宽均为载体图像的一半?
    x=imbinarize(x);
    y=imbinarize(y);

    [m, n]= size(y);

    subplot(2, 2, 1);
    imshow(x) ; title('原始图像'); 
    
    subplot(2, 2, 2); 
    imshow(y) ; title('水印图像'); 

    x=Hide(x,m,n,y);
    subplot(2, 2, 3); 
    imshow(x) ; title('伪装图像'); 

    t=Extract();
    subplot(2,2,4);
    imshow(t,[]); title("提取出的水印图像");
end


function out = BlackNum (x, index_row, index_col) 
    %计算区域内黑色块的数量 
    [~,n]=size(x);

    ny=n/2;

    count_in_y=(index_row-1)*ny+index_col;

    k=count_in_y*4-3; %对应到x中的第几个像素?
    
    

    %计算水印图中第i行j列的像素对应的x中四个像素的首个像素
    mx=idivide(int32(k),int32(n),"ceil");
    my=k-(mx-1)*n;

    out=0;
    for t=0:3
        if x(mx,my+t)==0
            out=out+1;
        end
    end
end 


function result=change_to_0(x,index_row,index_col,tem)
    %计算区域内黑色块的数量 
    [~,n]=size(x);

    ny=n/2;

    count_in_y=(index_row-1)*ny+index_col;

    k=count_in_y*4-3; %对应到中的第几个像素
    
    

    %计算水印图中第i行j列的像素对应的x中四个像素的首个像素
    mx=idivide(int32(k),int32(n),"ceil");
    my=k-(mx-1)*n;
    
    if tem==1
        %随机增加两个黑?
        rand1=int8(rand()*2+1);
        rand2=int8(rand()*2+1);
        while rand1==rand2
            rand1=int8(rand()*2+1);
            rand2=int8(rand()*2+1);
        end

        t=0;
        for q=0:3
            if x(mx,my+q)==1
                t=t+1;
                if t==rand1 || t==rand2
                    x(mx,my+q)=0;
                end
            end
        end

    elseif tem==2
        %随机增加一个黑
        randk=int8(rand()+1);
        t=0;
        for q=0:3
            if x(mx,my+q)==1
                t=t+1;
                if t==randk
                    x(mx,my+q)=0;
                end
            end
        end

    elseif tem==4
        %随机减去一个黑
        randk=int32(rand()*3);
        x(mx,my+randk)=1;

    end
    result=x;
end


function result=change_to_1(x,index_row,index_col,tem)
    %计算区域内黑色块的数量 
    [~,n]=size(x);

    ny=n/2;

    count_in_y=(index_row-1)*ny+index_col;

    k=count_in_y*4-3; %对应到x中的第几个像素?
    
    

    %计算水印图中第i行j列的像素对应的x中四个像素的首个像素
    mx=idivide(int32(k),int32(n),"ceil");
    my=k-(mx-1)*n;
    
    if tem==0
       %随机增加一个黑
        randk=int32(rand()*3);
        x(mx,my+randk)=0;

    elseif tem==2
       %随机减去一个黑
        randk=int8(rand()+1);
        t=0;
        for q=0:3
            if x(mx,my+q)==0
                t=t+1;
                if t==randk
                    x(mx,my+q)=1;
                end
            end
        end

    elseif tem==3
        %随机减去两个黑
        rand1=int8(rand()*2+1);
        rand2=int8(rand()*2+1);
        while rand1==rand2
            rand1=int8(rand()*2+1);
            rand2=int8(rand()*2+1);
        end

        t=0;
        for q=0:3
            if x(mx,my+q)==0
                t=t+1;
                if t==rand1 || t==rand2
                    x(mx,my+q)=1;
                end
            end
        end

    end
    result=x;
end


function result=Hide(x,m,n,y)
    for index_row=1:m
        for index_col=1:n
            tem=BlackNum(x,index_row,index_col);
            if y(index_row,index_col)==0 %要隐藏黑像素
                if tem==1 || tem==2 || tem==4   %改成三黑，三黑不用管?
                    x=change_to_0(x,index_row,index_col,tem);
                end
            elseif y(index_row,index_col)==1 %要 隐 藏 白 像 素
                if tem==0 || tem==2 || tem==3 %改成三白三白 （一 黑）不用管?
                    x=change_to_1(x,index_row,index_col,tem);
                end
            end
        end
    end

    imwrite(x , 'watermarkedImage.bmp'); 
    result=x;
end


function out=Extract()
    c=imread('watermarkedImage.bmp'); 
    [m, n]= size(c); 
    secret = zeros(m/2 , n/2);

    for index_row =1:m/2
        for index_col =1:n/2
            tem=BlackNum(c,index_row,index_col);
            if tem==1
                secret(index_row,index_col)=1;
            elseif tem==3
                secret(index_row,index_col)=0;
            elseif tem==0
                secret(index_row,index_col)=0;
            elseif tem==4
                secret(index_row,index_col)=1;
            end
        end 
    end
    imwrite(secret , 'watermark.bmp'); 
    out=secret;
end