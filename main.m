% function main()
pkg load image
mkdir('output')
input = {'img01.jpg' 'img02.jpg' 'img03.jpg' 'img04.jpg' 'img05.jpeg'};
catStr = 'output/';
% str = 'img01.jpg'
% str = 'img02.jpg'
% str = 'img03.jpg'
% str = 'img04.jpg'
str = 'img05.jpg'
img = imread(str);
h = fspecial('gaussian',[3,3],5);
convolutedImg = myImageFilter(img, h);
Convoluted = strcat(catStr,'convoluted-',str);
imwrite(convolutedImg, Convoluted);

sigma = 5;
[Im,Io,Ix,Iy] = myEdgeFilter(img, sigma);
sobelEdgeIm = strcat(catStr,'sobelEdgeIm-',str);
imwrite(Im, sobelEdgeIm);
sobelEdgeIo = strcat(catStr,'sobelEdgeIo-',str);
imwrite(Io, sobelEdgeIo);
sobelEdgeIx = strcat(catStr,'sobelEdgeIx-',str);
imwrite(Ix, sobelEdgeIx);
sobelEdgeIy = strcat(catStr,'sobelEdgeIy-',str);
imwrite(Iy, sobelEdgeIy);

threshold = 10;
harrisImg = img;
R = myHarrisCorner(Ix, Iy, threshold);
[row, col] = find (R > 0);
hold ("on");
imshow (img);
plot (col, row, "ro");
harrisCorner = strcat(catStr,'harrisCorner-',str);
print -djpg harrisCorner;
hold ("off");