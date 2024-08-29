close all
clear all;


% Parameters
yuvFileName = 'football_qcif.yuv';
width = 176;
height = 144;
searchRange = 7;

% Run EBMA function
EBMA(yuvFileName, width, height, searchRange);










function frame = readYUVFrame(fileID, width, height, frameNumber)
    % Seek to the frame position in the file
    frameSize = width * height * 1.5; % YUV 4:2:0 format
    fseek(fileID, (frameNumber - 1) * frameSize, 'bof');
    
    % Read Y component
    Y = fread(fileID, width * height, 'uchar');
    Y = reshape(Y, width, height)';
    
    % Skip U and V components (if not needed)
    fread(fileID, width * height / 2, 'uchar');
    
    % Output the frame
    frame = Y;
end



function EBMA(yuvFileName, width, height, searchRange)
    % Open the YUV file
    fileID = fopen(yuvFileName, 'r');
    
    % Read two adjacent frames from the YUV file
    frame1 = readYUVFrame(fileID, width, height, 1);
    frame2 = readYUVFrame(fileID, width, height, 2);
    
    % Close the file
    fclose(fileID);

    % Block size
    blockSize = 16;

    % Initialize motion vectors
    motionVectors = zeros(height/blockSize, width/blockSize, 2);

    % Initialize predicted frame
    predictedFrame = zeros(height, width);

    % Exhaustive block matching
    for i = 1:blockSize:height-blockSize+1
        for j = 1:blockSize:width-blockSize+1
            currentBlock = frame1(i:i+blockSize-1, j:j+blockSize-1);
            bestMAD = inf;
            bestMatch = [0, 0];

            for m = -searchRange:searchRange
                for n = -searchRange:searchRange
                    ref_i = i + m;
                    ref_j = j + n;
                    if ref_i > 0 && ref_j > 0 && ref_i+blockSize-1 <= height && ref_j+blockSize-1 <= width
                        refBlock = frame2(ref_i:ref_i+blockSize-1, ref_j:ref_j+blockSize-1);
                        mad = sum(sum(abs(double(currentBlock) - double(refBlock))));

                        if mad < bestMAD
                            bestMAD = mad;
                            bestMatch = [m, n];
                        end
                    end
                end
            end

            motionVectors((i-1)/blockSize+1, (j-1)/blockSize+1, :) = bestMatch;
            predictedBlock = frame2(i+bestMatch(1):i+bestMatch(1)+blockSize-1, j+bestMatch(2):j+bestMatch(2)+blockSize-1);
            predictedFrame(i:i+blockSize-1, j:j+blockSize-1) = predictedBlock;
        end
    end

    % Calculate prediction error
    predictionError = double(frame1) - double(predictedFrame);

    % Calculate PSNR
    mse = mean(predictionError(:).^2);
    psnrValue = 10 * log10(255^2 / mse);

    % Display results
    figure;
    subplot(2, 2, 1);
    imshow(uint8(frame1));
    title('Original Frame 1');

    subplot(2, 2, 2);
    imshow(uint8(frame2));
    title('Original Frame 2');

    subplot(2, 2, 3);
    imshow(uint8(predictedFrame));
    title('Predicted Frame');

    subplot(2, 2, 4);
    imshow(uint8(predictionError));
    title('Prediction Error');

    % Plot motion vectors
    [X, Y] = meshgrid(1:blockSize:width, 1:blockSize:height);
    U = motionVectors(:,:,2);
    V = motionVectors(:,:,1);

    figure;
    imshow(uint8(frame1));
    hold on;
    quiver(X, Y, U, V, 'r');
    title('Motion Vectors');
    hold off;

    % Print PSNR value
    fprintf('PSNR: %.2f dB\n', psnrValue);
end




