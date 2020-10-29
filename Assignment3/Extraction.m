key = 435;
rng(key);
LUT = rand(1,256)>0.5;

A = imread("YMwmkedKey435.tiff");

[rows, cols] = size(A);

watermark = cell(512,512);

for i = 1:rows
    for j = 1:cols
        pixel = A(i,j);
        if pixel == 0
            pixel = 1;
        end
        W(i,j) = LUT(pixel);
    end
end
