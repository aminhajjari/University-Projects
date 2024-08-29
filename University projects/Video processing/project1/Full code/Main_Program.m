clc;
close all;

X1 = imread('1.bmp');
X2 = imread('2.jpg');
X3 = imread('3.bmp');
X4 = imread('4.bmp');
X5 = imread('5.bmp');

X=X4;
SIZE=size(X)

X=im2double(X);

figure, imshow(X);


R=X(:,:,1);
G=X(:,:,2);
B=X(:,:,3);

figure;
subplot(3,1,1),imshow(R);
subplot(3,1,2),imshow(G);
subplot(3,1,3),imshow(B);


Y=im2double([]);
Y(:,:,1)=R;
Y(:,:,2)=G;
Y(:,:,3)=B;
figure, imshow(Y);


F1=save_yuvframe('foreman_qcif.yuv',[176 144],30,'F1.jpg');
F1=im2double(F1);

figure, imshow(F1);


R=F1(:,:,1);
G=F1(:,:,2);
B=F1(:,:,3);
figure;
subplot(3,1,1),imshow(R);
subplot(3,1,2),imshow(G);
subplot(3,1,3),imshow(B);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% RGB image to YUV image
YY = 0.299*R+0.587*G+0.114*B;
U =  -0.147*R-0.289*G+0.436*B + 0.436;     % Dc Offset = 0.436
V = 0.615*R-0.515*G-0.100*B + 0.615;       % Dc Offset = 0.615

figure;
subplot(3,1,1),imshow(YY);
subplot(3,1,2),imshow(U);
subplot(3,1,3),imshow(V);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% RGB image to YIQ image
YYY = 0.299*R+0.587*G+0.114*B
I =  0.596*R-0.275*G-0.321*B + 0.596;
Q = 0.212*R-0.523*G+0.311*B + 0.523;

figure;
subplot(3,1,1),imshow(YYY);
subplot(3,1,2),imshow(I);
subplot(3,1,3),imshow(Q);






%R=R(i,:);         %delete of a Row i
%R=R(:,j);         %delete of a colem j

Y1=Y;
i=1:2:SIZE(1,1);
j=1:2:SIZE(1,2);
Y1(i,:,:)=[];
Y1(:,j,:)=[];
size(Y1)
figure, imshow(Y1);

Y2=rgb2gray(X);
figure, imshow(Y2);

SY2=[];
SY2=Y2(4*16+1:5*16+1,8*16+1:9*16+1);
figure, imshow(SY2);

Edge1=edge(Y2,'canny');
figure, imshow(Edge1);

Edge2=edge(SY2,'canny');
figure, imshow(Edge2);

frames=seq_frames('foreman_qcif.yuv',[176 144],'420')                        %Returns the number of frames in YUV sequence file               function frames=seq_frames(filename,dims,format)

divide_seq('foreman_qcif.yuv',[176 144],100);                                               %Divides YUV sequence into segments                                       function divide_seq(filename,dims,frstep)



P1=save_yuvframe('foreman_qcif.yuv',[176 144],5,'P1.jpg');
figure, imshow(P1);
P2=save_yuvframe('foreman_qcif.yuv',[176 144],6,'P2.jpg');
figure, imshow(P2);
figure, imshow(P1-P2);


C=save_yuvframe('bus_cif.yuv',[352 288],5,'C.jpg');
figure, imshow(C);
Y2=rgb2gray(C);
figure, imshow(Y2);
Edge1=edge(Y2,'canny');
figure, imshow(Edge1);
