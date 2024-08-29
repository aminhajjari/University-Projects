function Show_Frames(First_Frame,Last_Frame);
close all;
for i=1:4;
    
P1 = save_yuvframe('G:\Digital Video Processing\Digital Video Processing\bus_cif.yuv',[352 288],i,'T1.png');
P2 = save_yuvframe('G:\Digital Video Processing\Digital Video Processing\cif1.yuv',[352 288],i,'T2.png');
P3 = save_yuvframe('G:\Digital Video Processing\Digital Video Processing\cif3.yuv',[352 288],i,'T3.png');
P4 = save_yuvframe('G:\Digital Video Processing\Digital Video Processing\cif4.yuv',[352 288],i,'T4.png');
P5 = save_yuvframe('G:\Digital Video Processing\Digital Video Processing\cif5.yuv',[352 288],i,'T5.png');
P6 = save_yuvframe('G:\Digital Video Processing\Digital Video Processing\cif6.yuv',[352 288],i,'T6.png');
P7 = save_yuvframe('G:\Digital Video Processing\Digital Video Processing\cif7.yuv',[352 288],i,'T7.png');
P8 = save_yuvframe('G:\Digital Video Processing\Digital Video Processing\cif8.yuv',[352 288],i,'T8.png');
figure;
subplot(331);
imshow(P1);
subplot(332);
imshow(P2);
subplot(333);
imshow(P7);
subplot(334);
imshow(P6);
subplot(335);
imshow(P4);
subplot(336);
imshow(P8);
subplot(337);
imshow(P3);
subplot(338);
imshow(P3-P4);
subplot(339);
imshow(P3-P8);

end


%x = imread('E:\EC_PROJ\COM_Proj\CIF_PROJ\T1.png');
%z=rgb2gray(x);
%z=im2double(x);
%x1 = im2double(rgb2gray(imread('E:\EC_PROJ\COM_Proj\CIF_PROJ\T1.png')));
%c=diag(corr(x1,x1));
%c=prod