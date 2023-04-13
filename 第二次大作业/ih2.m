[audio, fs] = audioread('test1.wav'); % 读取 WAV 文件
audiolength=length(audio);
msg=[1 0 1 0 1 0 1 0]; %待嵌入的消息
msglength=length(msg);
new_audio=audio;
for k=1:audiolength
    if k>msglength 
        break;
    end
    count=0;
    for i=1:16 %统计第 k 个字节中 1 的个数
        temp=bitget(new_audio(40+k),i);
        if temp==1
             count=count+1;
        end
    end
    if mod(count,2)==1 && msg(k)==0 %奇数变为偶数
        if bitget(new_audio(40+k),1)==1
            new_audio(40+k)=bitset(new_audio(40+k),1,0);
        else
            new_audio(40+k)=bitset(new_audio(40+k),1,1);
        end
    elseif mod(count,2)==0 && msg(k)==1 %偶数变为奇数
        if bitget(new_audio(40+k),1)==1
            new_audio(40+k)=bitset(new_audio(40+k),1,0);
        else
            new_audio(40+k)=bitset(new_audio(40+k),1,1);
        end
    end
end
fileId2=fopen('MarkedAudio.wav','wb');
fwrite(fileId2,new_audio,'int16'); % 将修改后的音频数据写入到新的 WAV 文件中
fclose(fileId2);
