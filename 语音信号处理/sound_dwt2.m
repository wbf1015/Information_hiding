[a,fs]=audioread('tada.wav'); 
[ca1,cd1]=dwt(a(:,1),'db4');%db4小波一级分解,取原音频的一个声道
a0=idwt(ca1,cd1,'db4',length(a(:,1)));%db4小波一级重构

figure
subplot(2,2,1);         plot(a(:,1));
subplot(2,2,2);         plot(cd1);
subplot(2,2,3);         plot(ca1);
subplot(2,2,4);         plot(a0);

axes_handle = get(gcf, 'children');
axes(axes_handle(4));   title('(1) wav original')
axes(axes_handle(3));   title('(2) detail component')
axes(axes_handle(2));   title('(3) approximation')
axes(axes_handle(1));   title('(4) wav recover')

