msglength=8;
[marked, fs] = audioread('MarkedAudio.wav'); % ��ȡ WAV �ļ�
for i=1:msglength
    count=0;
    for j=1:16 %ͳ�Ƶ� k ���ֽ��� 1 �ĸ���
        temp=bitget(marked(i),j);
        if temp==1
            count=count+1;
        end
    end
    if mod(count,2)==1 %���������� 1����������Ϣλ�� 1
        extractmsg(i)=1;
    else if mod(count,2)==0 %����ż���� 1����������Ϣλ�� 0
        extractmsg(i)=0;
        end
    end
end