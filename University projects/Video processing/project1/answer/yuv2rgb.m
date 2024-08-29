function rgb=yuv2rgb(Y,U,V)


yuv = zeros(size(Y,1),size(Y,2),3);
yuv(:,:,1) = double(Y);
yuv(:,:,2) = imresize(double(U),2,'bicubic');
yuv(:,:,3) = imresize(double(V),2,'bicubic');

%1) MS conversion from: http://msdn.microsoft.com/library/default.asp?
% url=/library/en-us/wceddraw/html/_dxce_converting_between_yuv_and_rgb.asp
%Conversion is defined with:
% C = Y - 16
% D = U - 128
% E = V - 128
% R = clip(( 298 * C           + 409 * E + 128) >> 8)
% G = clip(( 298 * C - 100 * D - 208 * E + 128) >> 8)
% B = clip(( 298 * C + 516 * D           + 128) >> 8)

%yuv(:,:,1) = yuv(:,:,1) - 16;
%yuv(:,:,2) = yuv(:,:,2) - 128;
%yuv(:,:,3) = yuv(:,:,3) - 128;
%rgb(:,:,1) = uint8((298*yuv(:,:,1) + 409*yuv(:,:,3) + 128)/256);
%rgb(:,:,2) = uint8((298*yuv(:,:,1) - 100*yuv(:,:,3) - 208*yuv(:,:,2))/256);
%rgb(:,:,3) = uint8((298*yuv(:,:,1) + 516*yuv(:,:,2) + 128)/256);

%2) Rec. ITU-R BT.601-4 conversion
% e.g. also from convertYuvToRgb conversion tool: 
%  http://www.mathworks.com/matlabcentral/fileexchange, 
%  and http://en.wikipedia.org/wiki/YCbCr
%
% The transform matrix T is (approximately) as follows:
%  1.000   0.000   1.402
%  1.116  -0.344  -0.551
%  0.402   1.772  -0.838

load rgb2yuvT.mat;
T = inv(rgb2yuvT);
rgb = zeros(size(Y,1),size(Y,2),3);

yuv(:,:,2:3) = yuv(:,:,2:3) - 127;
rgb(:,:,1) = T(1,1) * yuv(:,:,1) + T(1,2) * yuv(:,:,2) + T(1,3) * yuv(:,:,3);
rgb(:,:,2) = T(2,1) * yuv(:,:,1) + T(2,2) * yuv(:,:,2) + T(2,3) * yuv(:,:,3);
rgb(:,:,3) = T(3,1) * yuv(:,:,1) + T(3,2) * yuv(:,:,2) + T(3,3) * yuv(:,:,3);
rgb = uint8(rgb);