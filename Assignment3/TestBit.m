A = imread('peppers.tif');
A = double(A);

B = imread('baboon.tif');
B = double(B);

N = 3;
C = {};

for i = N+1:8
    C{i} = bitget(A , i);
end

for j = 8-(N-1):8
    D{j} = bitget(B,j);
end

ImArray = cell(1,8);
for i = 1:N
    ImArray{i} = D{8-(N-i)};
end

for j = N+1:8
    ImArray{j} = C{j};
end

for i = 0:7
    ImArray{i+1} = ImArray{i+1} * 2^i;
end

Im = imadd(ImArray{1}, ImArray{2});
Im = imadd(Im, ImArray{3});
Im = imadd(Im, ImArray{4});
Im = imadd(Im, ImArray{5});
Im = imadd(Im, ImArray{6});
Im = imadd(Im, ImArray{7});
Im = imadd(Im, ImArray{8});

b = bitget(Im, 1);

imshow(b);