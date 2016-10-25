function [Im Io Ix Iy] = myEdgeFilter(img, sigma)

    gaussImg = myImageFilter(img, fspecial('gaussian', [3 3], sigma));

    SobelX = [-1 0 1; -2 0 -2; -1 0 1];
    SobelY = [1 2 1; 0 0 0; -1 -2 -1];

    Ix = myImageFilter(gaussImg, SobelX);
    Ix = im2double(Ix);

    Iy = myImageFilter(gaussImg, SobelY);
    Iy = im2double(Iy);

    numRows = size(gaussImg,1);
    numCols = size(gaussImg,2);

    Im = zeros([numRows numCols]);

    Io = zeros([numRows numCols]);

    for i=1:numRows
        for j=1:numCols
            squaredSum = (Ix(i,j)*Ix(i,j)) + (Iy(i,j)*Iy(i,j));
            Im(i,j) = sqrt( squaredSum );
            y = abs(Iy(i,j));
            x = abs(Ix(i,j));
            Io(i,j) = atan( y / x );
            end
        end
    end

    % Non-maximum Suppression %
    for i = 1:numRows
        for j = 1:numCols
            if ((Io(i,j) >= 0 && Io(i,j) <= 15) || (Io(i,j) >= 165 && Io(i,j) <= 180))
                if i == 1
                    if Im(i+1,j) > Im(i,j)
                        Im(i,j) = 0;
                    end
                elseif i == size(Im,1)
                    if Im(i-1,j) > Im(i,j)
                        Im(i,j) = 0;
                    end
                else
                    if ((Im(i+1,j) > Im(i,j)) || (Im(i-1,j) > Im(i,j)))
                        Im(i,j) = 0;
                    end
                end
            elseif ((Io(i,j) >= 75) && (Io(i,j)<=105))
                if j == 1
                    if Im(i,j+1) > Im(i,j)
                        Im(i,j) = 0;
                    end
                elseif j == size(Im,2)
                    if Im(i,j-1) > Im(i,j)
                        Im(i,j) = 0;
                    end
                else
                    if ((Im(i,j+1) > Im(i,j)) || (Im(i,j-1) > Im(i,j)))
                        Im(i,j) = 0;
                    end
                end
            elseif ((Io(i,j) >= 30) && (Io(i,j) <= 60))
                if j == 1
                    if i == size(Im,1)
                        continue;
                    elseif Im(i+1,j+1) > Im(i,j)
                        Im(i,j) = 0;
                    end
                elseif j == size(Im,2)
                    if i == 1
                        continue;
                    elseif Im(i-1,j-1) > Im(i,j)
                        Im(i,j) = 0;
                    end
                else
                    if(i == 1)
                        if Im(i+1,j+1) > Im(i,j)
                            Im(i,j) = 0;
                        end
                    elseif i == size(Im,1)
                        if Im(i-1,j-1) > Im(i,j)
                            Im(i,j) = 0;
                        end 
                    else
                        if ((Im(i+1,j+1) > Im(i,j)) || (Im(i-1,j-1) > Im(i,j)))
                            Im(i,j) = 0;
                        end
                    end
                end
            elseif ((Io(i,j) <= 150) && (Io(i,j) >= 120))
                if j == 1 
                    if i == 1
                        continue;
                    elseif Im(i-1,j+1) > Im(i,j)
                        Im(i,j) = 0;
                    end
                elseif j == size(Im,2)
                    if i == size(Im,1)
                        continue;
                    elseif Im(i+1,j-1) > Im(i,j)
                        Im(i,j) = 0;
                    end
                else
                    if i == 1
                        if Im(i+1,j-1) > Im(i,j)
                            Im(i,j) = 0;
                        end
                    elseif i == size(Im,1)
                        if Im(i-1,j+1) > Im(i,j)
                            Im(i,j) = 0;
                        end 
                    else
                        if ((Im(i,j)<Im(i-1,j+1)) || (Im(i,j)<Im(i+1,j-1)))
                            Im(i,j) = 0;
                        end
                    end
                end
            end
        end
    end