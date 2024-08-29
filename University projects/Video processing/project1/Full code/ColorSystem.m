clc;
close all;

X1 = imread('1.bmp');
X2 = imread('2.jpg');
X3 = imread('3.bmp');
X4 = imread('4.bmp');
X5 = imread('5.bmp');

X=X4;
SIZE=size(X)

%imfinfo('1.bmp')
%imfinfo('2.jpg')
%imfinfo('3.bmp')

X=im2double(X);

figure, imshow(X);

%isrgb(X)

R=X(:,:,1);
G=X(:,:,2);
B=X(:,:,3);
figure;
subplot(3,1,1),imshow(R);
subplot(3,1,2),imshow(G);
subplot(3,1,3),imshow(B);


YYY = 0.299*R+0.587*G+0.114*B;
I =  0.596*R-0.275*G-0.321*B + 0.596;
Q = 0.212*R-0.523*G+0.311*B + 0.523;

figure;
subplot(3,1,1),imshow(YYY);
subplot(3,1,2),imshow(I);
subplot(3,1,3),imshow(Q);


YY = 0.299*R+0.587*G+0.114*B;
U =  -0.147*R-0.289*G+0.436*B + 0.436;     % Dc Offset = 0.436
V = 0.615*R-0.515*G-0.100*B + 0.615;       % Dc Offset = 0.615

figure;
subplot(3,1,1),imshow(YY);
subplot(3,1,2),imshow(U);
subplot(3,1,3),imshow(V);




















% %R=X(:,:,1);
% RR=X;
% RR(:,:,2)=zeros(SIZE(1,1),SIZE(1,2));
% RR(:,:,3)=zeros(SIZE(1,1),SIZE(1,2));
% figure;
% subplot(3,1,1),imshow(RR);

% %G=X(:,:,2);
% GG=X;
% GG(:,:,1)=zeros(SIZE(1,1),SIZE(1,2));
% GG(:,:,3)=zeros(SIZE(1,1),SIZE(1,2));
% subplot(3,1,2),imshow(GG);
% 
% %B=X(:,:,3);
% BB=X;
% BB(:,:,1)=zeros(SIZE(1,1),SIZE(1,2));
% BB(:,:,2)=zeros(SIZE(1,1),SIZE(1,2));
% subplot(3,1,3),imshow(BB);
% 
% %R=X(:,:,1);
% RRR=X;
% RRR(:,:,1)=255*ones(SIZE(1,1),SIZE(1,2));
% figure;
% subplot(3,1,1),imshow(RRR);
% 
% %G=X(:,:,2);
% GGG=X;
% GGG(:,:,2)=255*ones(SIZE(1,1),SIZE(1,2));
% subplot(3,1,2),imshow(GGG);
% 
% %B=X(:,:,3);
% BBB=X;
% BBB(:,:,3)=255*ones(SIZE(1,1),SIZE(1,2));
% subplot(3,1,3),imshow(BBB);
% 
