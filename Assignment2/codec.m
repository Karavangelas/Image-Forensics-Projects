Qmat = [16 11 10 16 24 40 51 61;
    12 12 14 19 26 58 60 55;
    14 13 16 24 40 57 69 56;
    14 17 22 29 51 87 80 62;
    18 22 37 56 68 109 103 77;
    24 35 55 64 81 104 113 92;
    49 64 78 87 103 121 120 101;
    72 92 95 98 112 100 103 99];

% read the input image

image = "peppers.tif";
I = imread(image);

%convert to double type
I = im2double(I);

%compute the dct on 8x8 blocks
dctt = @(blkstruct) dct(blkstruct.data);
D = blockproc(I, [8 8], dctt);


%quantize the dct coefficients using the above table
quant = @(blkstruct) ((blkstruct.data) ./ Qmat);
Q = blockproc(D, [8 8], quant);
Q = ceil(Q);

%convert matrix to vector

ZigZag = @(blkstruct) ZigzagMtx2Vector(blkstruct.data);
Z = blockproc(Q, [8 8], ZigZag);
[rowN, colN] = size(Z);
Z = Z';

%entropy encoding
enfile = JPEG_entropy_encode(rowN, colN, 8, Qmat, Z, '', 0);


% decode

[irowN, icolN, idtc_block_size, iQmat, iZ] = JPEG_entropy_decode('');

iZ = iZ';

% reconstructing the matrix from the vector
Vect = @(blkstruct) Vector2ZigzagMtx(blkstruct.data);
dZ = blockproc(iZ, [1 64], Vect);

% dequantizing the matrix
dequant = @(blkstruct) (iQmat .* blkstruct.data);
DCT = blockproc(dZ, [8 8], dequant);

% performing inverse dct on matrix to retrieve image
indct = @(blkstruct) idct(blkstruct.data);
origZ = blockproc(DCT, [8 8], indct);

origZ = uint8(origZ);

