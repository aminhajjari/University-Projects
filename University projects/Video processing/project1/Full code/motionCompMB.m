% Computes motion compensated image using the given motion vectors
%
% Input
%   imgI : The reference image 
%   motionVect : The motion vectors
%   mbSize : Size of the macroblock
%
% Ouput
%   imgComp : The motion compensated image
%
% Written by Aroh Barjatya

function imgComp = motionCompMB(imgC,imgI, mv_MB,mbCount, mbSize)
imageComp=imgC;
[row col] = size(imgI);


% we start off from the top left of the image
% we will walk in steps of mbSize
% for every marcoblock that we look at we will read the motion vector
% and put that macroblock from refernce image in the compensated image

%mbCount = 1;
colmb=rem(mbCount,11);
    if colmb==0
    colmb=11;
    else
    end
    rawmb=ceil(mbCount/11);
 i = rawmb*16-15;
 j = colmb*16-15;
        
        % dy is row(vertical) index
        % dx is col(horizontal) index
        % this means we are scanning in order
        
        dy = mv_MB(1);
        dx = mv_MB(2);
        refBlkVer = i + dy;
        refBlkHor = j + dx;
        
      if refBlkVer<1;
         refBlkVer=1;
      else
      end
      
      if refBlkHor<1;
         refBlkHor=1;
      else
      end

         if refBlkVer>129;
         refBlkVer=129;
      else
      end
      
      if refBlkHor>161;
         refBlkHor=161;
      else
      end

        imageComp(i:i+mbSize-1,j:j+mbSize-1) = imgI(refBlkVer:refBlkVer+mbSize-1, refBlkHor:refBlkHor+mbSize-1);
       % mbCount = mbCount + 1;
       
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
       %mbCount = 1;
colmb=rem(mbCount,11);
    if colmb==0
    colmb=11;
    else
    end
    rawmb=ceil(mbCount/11);
 i = rawmb*8-7;
 j = colmb*8-7;
     mbSize=8;    
        % dy is row(vertical) index
        % dx is col(horizontal) index
        % this means we are scanning in order
        
        dy = mv_MB(1);
        dx = mv_MB(2);
        
        %dy =0;
        %dx = 0;
      
        refBlkVer = i + round(dy/2);
        refBlkHor = j + round(dx/2);
        
      if refBlkVer<1;
         refBlkVer=1;
      else
      end
      
      if refBlkHor<1;
         refBlkHor=1;
      else
      end
      
         if refBlkVer>65;
         refBlkVer=65;
      else
      end
      
      if refBlkHor>81;
         refBlkHor=81;
      else
      end

        imageComp(i+144:i+144+mbSize-1,j:j+mbSize-1) = imgI(refBlkVer+144:refBlkVer+144+mbSize-1, refBlkHor:refBlkHor+mbSize-1);
        imageComp(i+144:i+144+mbSize-1,j+88:j+88+mbSize-1) = imgI(refBlkVer+144:refBlkVer+144+mbSize-1, refBlkHor+88:refBlkHor+88+mbSize-1);
       % mbCount = mbCount + 1;
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 imgComp = imageComp;

