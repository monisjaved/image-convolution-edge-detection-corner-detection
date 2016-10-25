function [R] = myHarrisCorner(Ix, Iy, threshold)

    w = 1;
    k = 0.04;

    numRows = size(Ix,1);
    numCols = size(Ix,2);

    R = zeros(numRows,numCols);

    Ix2 = Ix.*Ix;
    Iy2 = Iy.*Iy;
    Ixy = Ix.*Iy;

    startRow = 1;
    endRow = numRows;
    startCol = 1;
    endCol = numCols;

    for i = startRow:endRow
        for j = startCol:endCol
            detMatrix = ((Ix2(i,j)*Iy2(i,j)) - (Ixy(i,j)*Ixy(i,j)));
            traceMatrix = (Ix2(i,j) + Iy2(i,j));
            corner = detMatrix - (k * (traceMatrix * traceMatrix));
            % if corner > threshold
            %     R(i,j) = corner
            % end
            R(i,j) = corner
        end
    end
end
