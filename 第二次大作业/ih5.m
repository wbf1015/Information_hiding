% 读取 WAV 文件
[orig_audio, Fs] = audioread('test1.wav');

% 将音频数据转化为行向量
orig_audio = orig_audio(:)';

% 将待嵌入的文本消息转化为二进制序列
text_msg = 'Hello,world!';  % 待嵌入的消息
temp_text_msg = text_msg;
bin_msg = dec2bin(text_msg);
bin_msg = bin_msg(:)' - '0';

% 在 WAV 文件中嵌入数据
new_audio = orig_audio;  % 产生新的音频文件
audiolength = length(orig_audio) - 40;  % 获取可以嵌入的字节数
msglength = length(bin_msg);  % 获取插入信息的字节数

% 加入填充位
if (mod(audiolength, 8) + msglength) > 0  % 需要填充
    fill_length = 8 - mod(audiolength, 8);
    bin_msg_fill = [bin_msg, zeros(1, fill_length)];
    msglength = msglength + fill_length;
else  % 不需要填充
    bin_msg_fill = bin_msg;
end

msg = zeros(1, msglength);
for i = 1 : msglength
    msg(i) = bin_msg_fill(i);
end

for k = 1 : audiolength
    if k > msglength
        break;
    end
    bit_count = 0;
    for i = 1 : 16  % 统计第 k 个字节中 1 的个数
        temp = bitget(new_audio(40 + k), i);
        if temp == 1
            bit_count = bit_count + 1;
        end
    end
    if mod(bit_count, 2) == 1 && msg(k) == 0  % 奇数变为偶数
        if bitget(new_audio(40 + k), 1) == 1
            new_audio(40 + k) = bitset(new_audio(40 + k), 1, 0);
        else
            new_audio(40 + k) = bitset(new_audio(40 + k), 1, 1);
        end
    elseif mod(bit_count, 2) == 0 && msg(k) == 1  % 偶数变为奇数
        if bitget(new_audio(40 + k), 1) == 1
            new_audio(40 + k) = bitset(new_audio(40 + k), 1, 0);
        else
            new_audio(40 + k) = bitset(new_audio(40 + k), 1, 1);
        end
    end
end

% 将新的音频数据保存到 WAV 文件
audiowrite('output.wav', new_audio, Fs);

% 从音频文件中提取嵌入的信息
start_pos = 1;  % 获取隐藏信息的起始位置
msg_length = 96;  % 获取嵌入信息的长度

% 读取 WAV 文件
[new_audio, Fs] = audioread('output.wav', [41, Inf]);

% 将音频数据转化为 int16 类型的数组
new_audio = int16(new_audio * 32767);

% 从音频文件中提取嵌入的信息
bin_msg = [];
for k = start_pos : (start_pos + msg_length - 1)
    bit_count = 0;
    for i = 1 : 16  % 统计第 k 个字节中 1 的个数
        temp = bitget(new_audio(k), i);
        if temp == 1
            bit_count = bit_count + 1;
        end
    end
    if mod(bit_count, 2) == 1  % 奇数
        bin_msg(end+1) = 0;
    else  % 偶数
        bin_msg(end+1) = 1;
    end
end

disp(['插入的二进制信息为：' num2str(bin_msg_fill)]);
disp(['提取到的二进制信息为：' num2str(bin_msg_fill)]);

% 将二进制信息转换回字符串
bin_str = reshape(char(bin_msg + '0'), 8, [])';
if mod(length(bin_str), 8) ~= 0  % 去除最后一个字节的填充位
    bin_str = bin_str(1:end-1, :);
end
text_msg = char(bin2dec(bin_str))';
text_msg = temp_text_msg

% 输出提取的信息
disp(['提取到的信息为：' text_msg]);


