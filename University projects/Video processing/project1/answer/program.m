clc;
clear;

q1=save_yuvframe('D:\uni\term2\video processing\tamrin1\foreman_qcif.yuv',[176 144],54,'Foreman.jpg');

Image = imread('D:\uni\term2\video processing\tamrin1\Foreman.jpg');

Image=im2double(Image);

figure;
imshow(Image);
title("Original Image")

R=Image(:,:,1);
G=Image(:,:,2);
B=Image(:,:,3);

figure;
subplot(3,1,1)
imshow(R);
title("RGB Image")
subplot(3,1,2)
imshow(G);
subplot(3,1,3)
imshow(B);


Y1 = 0.299*R + 0.587*G + 0.114*B;
U1 = -0.147*R - 0.289*G + 0.436*B;
V1 = 0.615*R - 0.515*G - 0.100*B;

figure;
subplot(3,1,1)
imshow(Y1);
title("YUV Image")
subplot(3,1,2)
imshow(U1);
subplot(3,1,3)
imshow(V1);


Y2 = 0.299*R + 0.587*G + 0.114*B;
I1 = 0.596*R - 0.274*G - 0.322*B;
Q1 = 0.211*R - 0.523*G + 0.312*B;

figure;
subplot(3,1,1)
imshow(Y1);
title("YIQ Image")
subplot(3,1,2)
imshow(I1);
subplot(3,1,3)
imshow(Q1);


A = im2double(Y2);
B = im2double(Q1);

[l, k] = size(A);

C = zeros(l, k);

for x = 1:l
    for y = 1:k
        sum = 0;
        for m = 1:l-1
            for n = 1:k-1
                if x+m<=l && y+n<=k
                    sum = sum + A(m+1,n+1) * B(x+m,y+n);
                end
            end
        end
        C(x, y) = sum;
    end
end

figure;
imshow(C, []);
title("Correlation")