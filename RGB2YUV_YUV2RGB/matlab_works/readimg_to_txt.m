function img_size = readimg_to_txt(input_bmp, output_txt);
% bmp to Verilog memory init txt file
% retuen size

img = imread(input_bmp);
figure, imshow(img);

fid = fopen(output_txt, 'w');
fprintf(fid, '@00\r\n');
[rows ,cols] = size(img);
for m = 1:rows
   for n = 1:cols
       if (mod(n,1280) == 0) 
           fprintf(fid, '%2x\r\n', img(m, n));
       else
          fprintf(fid, '%2x ', img(m, n)); 
       end   
   end
   fprintf(fid, '\r\n');
end

fclose(fid);
img_size.width = cols;
img_size.high = rows;


