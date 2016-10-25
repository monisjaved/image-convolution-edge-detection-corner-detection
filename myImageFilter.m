function [img1] = myImageFilter(img0, h)

    if size(img0,3) == 3
        img0 = rgb2gray(img0);
    end


    img1 = zeros(size(img0));
    % size(img1)    


    numRows = floor(size(h,1)/2);
    numCols = floor(size(h,2)/2);

    paddedImg0 = padarray(img0, [numRows numCols], 'replicate');
    numPaddedRows = size(paddedImg0,1);
    numPaddedCols = size(paddedImg0,2);

    startRow = 1 + numRows;
    endRow = numPaddedRows - numRows;
    startCol = 1 + numCols;
    endCol = numPaddedCols - numCols;


    for i=startRow:endRow
        for j=startCol:endCol
            elemSum = 0;
            for m=-numRows:numRows
                for n=-numCols:numCols
                    elemSum = elemSum + (h(m+numRows+1,n+numCols+1) * paddedImg0(i+m,j+n));
                end
            end
            if elemSum < 0
                elemSum = 0;
            else if elemSum > 255
                elemSum = 255;
            end
            img1(i-numRows,j-numCols) = elemSum;      
        end
    end
    img1 = im2uint8(img1);
end