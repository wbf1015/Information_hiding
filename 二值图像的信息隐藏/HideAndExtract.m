function HideAndExtract()
    x=imread ('Lena.bmp'); %����ͼ���ǻҶ�ͼ��?
    y=imread ('lion.bmp');  %������Ϣͼ���ǻҶ�ͼ�񣬳����Ϊ����ͼ���һ��?
    x=imbinarize(x);
    y=imbinarize(y);

    [m, n]= size(y);

    subplot(2, 2, 1);
    imshow(x) ; title('ԭʼͼ��'); 
    
    subplot(2, 2, 2); 
    imshow(y) ; title('ˮӡͼ��'); 

    x=Hide(x,m,n,y);
    subplot(2, 2, 3); 
    imshow(x) ; title('αװͼ��'); 

    t=Extract();
    subplot(2,2,4);
    imshow(t,[]); title("��ȡ����ˮӡͼ��");
end


function out = BlackNum (x, i, j) 
    %���������ں�ɫ������� 
    [~,n]=size(x);

    ny=n/2;

    count_in_y=(i-1)*ny+j;

    k=count_in_y*4-3; %��Ӧ��x�еĵڼ�������?
    
    

    %����ˮӡͼ�е�i��j�е����ض�Ӧ��x���ĸ����ص��׸�����
    mx=idivide(int32(k),int32(n),"ceil");
    my=k-(mx-1)*n;

    out=0;
    for t=0:3
        if x(mx,my+t)==0
            out=out+1;
        end
    end
end 


function result=change_to_0(x,i,j,tem)
    %���������ں�ɫ������� 
    [~,n]=size(x);

    ny=n/2;

    count_in_y=(i-1)*ny+j;

    k=count_in_y*4-3; %��Ӧ���еĵڼ�������
    
    

    %����ˮӡͼ�е�i��j�е����ض�Ӧ��x���ĸ����ص��׸�����
    mx=idivide(int32(k),int32(n),"ceil");
    my=k-(mx-1)*n;
    
    if tem==1
        %�������������?
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
        %�������һ����
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
        %�����ȥһ����
        randk=int32(rand()*3);
        x(mx,my+randk)=1;

    end
    result=x;
end


function result=change_to_1(x,i,j,tem)
    %���������ں�ɫ������� 
    [~,n]=size(x);

    ny=n/2;

    count_in_y=(i-1)*ny+j;

    k=count_in_y*4-3; %��Ӧ��x�еĵڼ�������?
    
    

    %����ˮӡͼ�е�i��j�е����ض�Ӧ��x���ĸ����ص��׸�����
    mx=idivide(int32(k),int32(n),"ceil");
    my=k-(mx-1)*n;
    
    if tem==0
       %�������һ����
        randk=int32(rand()*3);
        x(mx,my+randk)=0;

    elseif tem==2
       %�����ȥһ����
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
        %�����ȥ������
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
    for i=1:m
        for j=1:n
            tem=BlackNum(x,i,j);
            if y(i,j)==0 %Ҫ���غ�����
                if tem==1 || tem==2 || tem==4   %�ĳ����ڣ����ڲ��ù�?
                    x=change_to_0(x,i,j,tem);
                end
            elseif y(i,j)==1 %Ҫ �� �� �� �� ��
                if tem==0 || tem==2 || tem==3 %�ĳ��������� ��һ �ڣ����ù�?
                    x=change_to_1(x,i,j,tem);
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

    for i =1:m/2
        for j =1:n/2
            tem=BlackNum(c,i,j);
            if tem==1
                secret(i,j)=1;
            elseif tem==3
                secret(i,j)=0;
            elseif tem==0
                secret(i,j)=0;
            elseif tem==4
                secret(i,j)=1;
            end
        end 
    end
    imwrite(secret , 'watermark.bmp'); 
    out=secret;
end