import struct

'''
将s中以index为下标的值换成value
在本代码中使用的十六进制字符串
'''
def replaceHex(s,index,value):
    l = list(s)
    l[index] = value
    res = "".join(l)
    return res


'''
通过输入一个字符串s,将其逐个字符转换为ascii码格式
然后再将ascii码转换为二进制码
'''
def GenInformation2Hide(s):
    ret = ""
    for alphabat in s:
        i = ord(alphabat)
        binum = bin(i)
        binum = binum[2:]
        while len(binum) < 8:
            binum = '0' + binum
        ret = ret + binum
    return ret

'''
在本次实验中将隐藏的信息藏在第四个OGG页开始的位置
'''
def FindStrIndex(s):
    index1 = s.find('4f6767')
    index2 = s.find('4f6767',index1+3)
    index3 = s.find('4f6767',index2+3)
    index4 = s.find('4f6767',index3+3)
    return index4

'''
计算应该用哪个字符代替原来的字符c
如果one是true代表二进制结尾应该是1
'''
def CalReplaceChar(c,one):
    if one:
        if (c=='1')|(c=='3')|(c=='5')|(c=='7')|(c=='9')|(c=='b')|(c=='d')|(c=='f'):
            return c
        if c=='0':
            return '1'
        if c=='2':
            return '3'
        if c=='4':
            return '5'
        if c=='6':
            return '7'
        if c=='8':
            return '9'
        if c=='a':
            return 'b'
        if c=='c':
            return 'd'
        if c=='e':
            return 'f'
    else:
        if (c=='0')|(c=='2')|(c=='4')|(c=='6')|(c=='8')|(c=='a')|(c=='c')|(c=='e'):
            return c
        if c=='1':
            return '0'
        if c=='3':
            return '2'
        if c=='5':
            return '4'
        if c=='7':
            return '6'
        if c=='9':
            return '8'
        if c=='b':
            return 'a'
        if c=='d':
            return 'c'
        if c=='f':
            return 'e'
        
'''
将hide_information隐藏到origin_data以index2hide开始的位置
'''
def HideInformation(origin_data,index2hide,hide_information):
    count = 0
    od = origin_data
    for char in hide_information:
        # print('end = ',char)
        # print('origin_data = ',od[index2hide+count])
        # if char == '1':
        #     print('2Replace = ',CalReplaceChar(od[index2hide+count],True))
        # if char == '0':
        #     print('2Replace = ',CalReplaceChar(od[index2hide+count],False))
        if char =='1':
            od = replaceHex(od,index2hide+count,CalReplaceChar(od[index2hide+count],True))
            pass
        if char =='0':
            od = replaceHex(od,index2hide+count,CalReplaceChar(od[index2hide+count],False))
        count += 1
    return od

'''
从data的begin位置按lsb方法提取l比特的信息
'''
def PatchInformation(data,begin,l):
    infor = ""
    zero = ['0','2','4','6','8','a','c','e']
    one = ['1','3','5','7','9','b','d','f']
    for i in range(0,l):
        if data[begin+i] in zero:
            infor = infor + '0'
        if data[begin+i] in one:
            infor = infor + '1'
    
    char_length = l//8
    ans = ""
    for i in range(0,char_length):
        temp = infor[i*8:(i+1)*8]
        num = int(temp,2)
        ch = chr(num)
        ans = ans + ch
    
    return ans
        
    
'''
整个隐藏以及提取信息的pipeline
'''
def pipline():
    binary_data = None
    hex_data = None
    with open('信息隐藏示例音频.ogg', 'rb') as f:
        binary_data = f.read()
    hex_data = binary_data.hex()
    print('[PIPELINE LOG] SUCCESSFULLY READ OGG FILE')
    print('[PIPELINE LOG] DISPLAY HEAD OF THE OGG FILE:',hex_data[:20])
    index = FindStrIndex(hex_data)
    index = index+27+255
    print('[PIPELINE LOG] DISPLAY HIDING INDEX:',index)
    # 在这里更改你想要隐藏的信息，因为没有encode和decode所以只能隐藏英文、数字和一些特殊字符
    hide_infor = GenInformation2Hide('NKU')
    print('[PIPELINE LOG] INFORMATION 2 HIDE IS: ',hide_infor)
    hex_data2 = HideInformation(hex_data,index,hide_infor)
    byte = bytes.fromhex(hex_data2)
    # 打开文件，并以二进制写入模式写入二进制数据
    with open('隐藏后音频.ogg', 'wb') as f:
        f.write(byte)
    print('[PIPELINE LOG] SUCCESSFULLY DONE INFORMATION HIDING!')
    binary_data2 = None
    with open('隐藏后音频.ogg', 'rb') as f:
        binary_data2 = f.read()
    hex_data2 = binary_data2.hex()
    print('[PIPELINE LOG] START PATCHING INFORMATION FROM OGG FILE')
    print('PIPELINE LOG] SUCCESSFULLY DONE INFORMATION PATCHING! INFORMATION IS :',PatchInformation(hex_data2,index,len(hide_infor)))
    



if __name__ == '__main__':
    pipline()