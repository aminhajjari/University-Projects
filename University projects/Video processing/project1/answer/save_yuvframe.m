function [C,Y,U,V]=save_yuvframe(yuvfile,dims,frm,outimage)
;

[Y, U, V] = yuv_import(yuvfile,dims,1,frm);
[pathstr,name,ext] = fileparts(outimage);
C = [];
if (isempty(ext))
    fid=fopen([outimage 'Y.raw'],'w');
    fwrite(fid,Y{1}','uint8');
    fclose(fid);
    fid=fopen([outimage 'U.raw'],'w');
    fwrite(fid,U{1}','uint8');
    fclose(fid);
    fid=fopen([outimage 'V.raw'],'w');
    fwrite(fid,V{1}','uint8');
    fclose(fid);    
    %yuv_export(Y,U,V,[outimage '.raw'], 1);
else %save as image, using the specified extension to determine the format
    C=yuv2rgb(Y{1},U{1},V{1});
    imwrite(C,outimage);
end