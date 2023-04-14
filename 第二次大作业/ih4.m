msglength=8;
[marked, fs] = audioread('MarkedAudio.wav'); % 读取 WAV 文件
for i=1:msglength
    count=0;
    for j=1:16 %统计第 k 个字节中 1 的个数
        temp=bitget(marked(i),j);
        if temp==1
            count=count+1;
        end
    end
    if mod(count,2)==1 %若含奇数个 1，则秘密信息位是 1
        extractmsg(i)=1;
    else if mod(count,2)==0 %若含偶数个 1，则秘密信息位是 0
        extractmsg(i)=0;
        end
    end
end