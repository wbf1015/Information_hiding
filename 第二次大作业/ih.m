for k=1:audiolength
    if k>msglength 
        break;
    end
    count=0;
    for i=1:16 %ͳ�Ƶ� k ���ֽ��� 1 �ĸ���
        temp=bitget(new_audio(40+k),i);
        if temp==1
             count=count+1;
        end
    end
    if mod(count,2)==1 && msg(k)==0 %������Ϊż��
        if bitget(new_audio(40+k),1)==1
            new_audio(40+k)=bitset(new_audio(40+k),1,0);
        else
            new_audio(40+k)=bitset(new_audio(40+k),1,1);
        end
    else if mod(count,2)==0 && msg(k)==1 %ż����Ϊ����
        if bitget(new_audio(40+k),1)==1
            new_audio(40+k)=bitset(new_audio(40+k),1,0);
        else
            new_audio(40+k)=bitset(new_audio(40+k),1,1);
        end
        end
    end
end
fileId2=fopen('MarkedAudio.wav','wb');
fwrite(fileId2,new_audio,'uchar');
fclose(fileId2);