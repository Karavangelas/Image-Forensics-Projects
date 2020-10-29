rng(1);
LUTvals = rand(1,256)>0.5;

A = imread("peppers.tif");

B = imread("Barbara.bmp");

B = im2bw(B, 0.5);

B = double(B);

B = bitget(B, 8);

[rowsA, colsA] = size(A);

[rowsB, colsB] = size(B);

for i = 1:rowsA
    for j = 1:rowsB
        
        pixel = A(i,j);
        
        if pixel==0
            pixel = 1;
        end
        
        found = 0;
        
        inc = 1;
        
        while found == 0
            if B(i,j) == LUTvals(1, pixel)
                found = 1;
            else
               if B(i,j) == LUTvals(1, pixel+inc)
                   A(i,j) = pixel+inc;
                   found = 1;
               elseif B(1,j) == LUTvals(1, pixel-inc)
                   A(i,j) = pixel-inc;
                   found = 1;
               else
                   inc = inc + 1;
               end
            end
        end
    end
end

A = uint8(A);


