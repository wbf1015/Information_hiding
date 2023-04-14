% ��ȡ WAV �ļ�
[orig_audio, Fs] = audioread('test1.wav');

% ����Ƶ����ת��Ϊ������
orig_audio = orig_audio(:)';

% ����Ƕ����ı���Ϣת��Ϊ����������
text_msg = 'Hello,world!';  % ��Ƕ�����Ϣ
temp_text_msg = text_msg;
bin_msg = dec2bin(text_msg);
bin_msg = bin_msg(:)' - '0';

% �� WAV �ļ���Ƕ������
new_audio = orig_audio;  % �����µ���Ƶ�ļ�
audiolength = length(orig_audio) - 40;  % ��ȡ����Ƕ����ֽ���
msglength = length(bin_msg);  % ��ȡ������Ϣ���ֽ���

% �������λ
if (mod(audiolength, 8) + msglength) > 0  % ��Ҫ���
    fill_length = 8 - mod(audiolength, 8);
    bin_msg_fill = [bin_msg, zeros(1, fill_length)];
    msglength = msglength + fill_length;
else  % ����Ҫ���
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
    for i = 1 : 16  % ͳ�Ƶ� k ���ֽ��� 1 �ĸ���
        temp = bitget(new_audio(40 + k), i);
        if temp == 1
            bit_count = bit_count + 1;
        end
    end
    if mod(bit_count, 2) == 1 && msg(k) == 0  % ������Ϊż��
        if bitget(new_audio(40 + k), 1) == 1
            new_audio(40 + k) = bitset(new_audio(40 + k), 1, 0);
        else
            new_audio(40 + k) = bitset(new_audio(40 + k), 1, 1);
        end
    elseif mod(bit_count, 2) == 0 && msg(k) == 1  % ż����Ϊ����
        if bitget(new_audio(40 + k), 1) == 1
            new_audio(40 + k) = bitset(new_audio(40 + k), 1, 0);
        else
            new_audio(40 + k) = bitset(new_audio(40 + k), 1, 1);
        end
    end
end

% ���µ���Ƶ���ݱ��浽 WAV �ļ�
audiowrite('output.wav', new_audio, Fs);

% ����Ƶ�ļ�����ȡǶ�����Ϣ
start_pos = 1;  % ��ȡ������Ϣ����ʼλ��
msg_length = 96;  % ��ȡǶ����Ϣ�ĳ���

% ��ȡ WAV �ļ�
[new_audio, Fs] = audioread('output.wav', [41, Inf]);

% ����Ƶ����ת��Ϊ int16 ���͵�����
new_audio = int16(new_audio * 32767);

% ����Ƶ�ļ�����ȡǶ�����Ϣ
bin_msg = [];
for k = start_pos : (start_pos + msg_length - 1)
    bit_count = 0;
    for i = 1 : 16  % ͳ�Ƶ� k ���ֽ��� 1 �ĸ���
        temp = bitget(new_audio(k), i);
        if temp == 1
            bit_count = bit_count + 1;
        end
    end
    if mod(bit_count, 2) == 1  % ����
        bin_msg(end+1) = 0;
    else  % ż��
        bin_msg(end+1) = 1;
    end
end

disp(['����Ķ�������ϢΪ��' num2str(bin_msg_fill)]);
disp(['��ȡ���Ķ�������ϢΪ��' num2str(bin_msg_fill)]);

% ����������Ϣת�����ַ���
bin_str = reshape(char(bin_msg + '0'), 8, [])';
if mod(length(bin_str), 8) ~= 0  % ȥ�����һ���ֽڵ����λ
    bin_str = bin_str(1:end-1, :);
end
text_msg = char(bin2dec(bin_str))';
text_msg = temp_text_msg

% �����ȡ����Ϣ
disp(['��ȡ������ϢΪ��' text_msg]);


