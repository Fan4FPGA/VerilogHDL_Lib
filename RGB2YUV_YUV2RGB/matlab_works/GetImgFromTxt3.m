function img = GetImgFromTxt3(ImgTxt_File_Name_r, ImgTxt_File_Name_g,ImgTxt_File_Name_b,Col, Row, OutImgFile_Name);

fid = fopen(ImgTxt_File_Name_r, 'r');

img = fscanf(fid,'%x',[Col Row]);
img = img';

imshow(img),title('The image');
image1_in_r = uint8(zeros(Row,Col));
for row = 1:Row
    for col = 1:Col
         image1_in_r(row, col) = img(row, col);
     end
end
% subplot(251);     
%imshow(image1_in_r),title('The grey r image');


fid = fopen(ImgTxt_File_Name_g, 'r');

img = fscanf(fid,'%x',[Col Row]);
img = img';

%imshow(img),title('The image');
image1_in_g = uint8(zeros(Row,Col));
for row = 1:Row
    for col = 1:Col
         image1_in_g(row, col) = img(row, col);
     end
end
%  subplot(252);    
%imshow(image1_in_g),title('The grey g image');


fid = fopen(ImgTxt_File_Name_b, 'r');

img = fscanf(fid,'%x',[Col Row]);
img = img';

%imshow(img),title('The image');
image1_in_b = uint8(zeros(Row,Col));
for row = 1:Row
    for col = 1:Col
         image1_in_b(row, col) = img(row, col);
     end
end
% subplot(253);    
%imshow(image1_in_b),title('The grey b image');

 % subplot(254); 
image1_out_rgb = cat(3,image1_in_r,image1_in_g,image1_in_b);
imshow(image1_out_rgb),title('The grey rgb image');
imwrite(image1_out_rgb, OutImgFile_Name, 'bmp');
fclose(fid);