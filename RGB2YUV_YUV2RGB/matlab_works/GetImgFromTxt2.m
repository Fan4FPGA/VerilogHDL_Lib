function img = GetImgFromTxt2(ImgTxt_File_Name, Col, Row, OutImgFile_Name);

fid = fopen(ImgTxt_File_Name, 'r');

img = fscanf(fid,'%x',[Col Row]);
img = img';

imshow(img),title('The image');
image1_in_y = uint8(zeros(Row,Col));
for row = 1:Row
    for col = 1:Col
         image1_in_y(row, col) = img(row, col);
     end
end
     
imshow(image1_in_y),title('The grey y image');
imwrite(image1_in_y, OutImgFile_Name, 'bmp');
fclose(fid);




