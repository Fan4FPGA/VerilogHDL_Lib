function img_pic = GetImgFromTxt(ImgTxt_File_Name, Col, Row, Threshold, OutImgFile_Name);

% Get image from a txt file that Verilog output
% ͼ����ΪCol��ͼ��߶�ΪRow����Verilog����ĵ�һ�к����һ��ȱʧ��Ӧ����д�㣩

fid = fopen(ImgTxt_File_Name, 'r');

img = fscanf(fid,'%x',[Col Row-2]);
img = img';
figure('Name', '���ȵ���ͼ'), imshow(img)

for row = 1:Row
    for col = 1:Col
        if (row == 1 | row == Row)
            img_pic(row, col) = uint8(0);
        elseif (img(row-1, col) > Threshold)
            img_pic(row, col) = uint8(255);
        else
            img_pic(row, col) = uint8(0);
        end
     end
end
        
figure('Name', 'ͼ���Ե'), imshow(img_pic)
imwrite(img_pic, OutImgFile_Name, 'bmp');

fclose(fid);




