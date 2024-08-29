function frames=seq_frames(filename,dims,format)
%Returns the number of frames in YUV sequence file
%frames=seq_frames(filename,dims,format)
%Version: 1.01, Date: 2006/05/25, author: Nikola Sprljan
%
%Input:
% filename - YUV sequence file
% dims - dimensions of the frame [width height]
% format - YUV subsampling format
%
%Examples:
% frames = seq_frames('football.yuv',[352 288],'420');

if (nargin < 3)
    format = '420';
end;

if (strcmp(format,'420'))
    Ysiz = prod(dims);
    UVsiz = Ysiz / 4;
    frelem = Ysiz + 2*UVsiz;
else
    error('Unknown format!');
end;
fid=fopen(filename,'r');
if (fid == -1) 
    error('Cannot open file');
end;
fseek(fid, 0, 'eof');
yuvbytes = ftell(fid);
frames = floor(yuvbytes / frelem);
fclose(fid);
