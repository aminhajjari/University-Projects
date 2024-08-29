close all
clear all




% Run the motion estimation with the specified parameters
runMotionEstimation('football_qcif.yuv', 176, 144, 7, 16);



% Read YUV Frame Function
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

% Main function to run motion estimation
function runMotionEstimation(yuvFileName, width, height, searchRange, blockSize)
    % Open the YUV file
    fileID = fopen(yuvFileName, 'r');
    
    % Read frames 70 and 71 from the YUV file
    frame1 = readYUVFrame(fileID, width, height, 70);
    frame2 = readYUVFrame(fileID, width, height, 71);
    
    % Close the file
    fclose(fileID);
    
    % Perform 2D-Log Search
    tic;
    motionVectorsLog = logSearch(frame1, frame2, blockSize, searchRange);
    timeLog = toc;
    
    % Perform Three-Step Search
    tic;
    motionVectorsThreeStep = threeStepSearch(frame1, frame2, blockSize, searchRange);
    timeThreeStep = toc;
    
    % Calculate and display results for 2D-Log
    predictedFrameLog = predictFrame(frame2, motionVectorsLog, blockSize);
    mseLog = mean((double(frame1(:)) - double(predictedFrameLog(:))).^2);
    psnrLog = 10 * log10(255^2 / mseLog);
    
    % Calculate and display results for Three-Step
    predictedFrameThreeStep = predictFrame(frame2, motionVectorsThreeStep, blockSize);
    mseThreeStep = mean((double(frame1(:)) - double(predictedFrameThreeStep(:))).^2);
    psnrThreeStep = 10 * log10(255^2 / mseThreeStep);
    
    % Display results
    disp('2D-Log Search Results:');
    disp(['PSNR: ', num2str(psnrLog), ' dB']);
    disp(['Execution Time: ', num2str(timeLog), ' seconds']);
    
    disp('Three-Step Search Results:');
    disp(['PSNR: ', num2str(psnrThreeStep), ' dB']);
    disp(['Execution Time: ', num2str(timeThreeStep), ' seconds']);
    
    % Plot results
    figure;
    subplot(2, 2, 1);
    imshow(uint8(frame1));
    title('Original Frame 1');
    
    subplot(2, 2, 2);
    imshow(uint8(frame2));
    title('Original Frame 2');
    
    subplot(2, 2, 3);
    imshow(uint8(predictedFrameLog));
    title('Predicted Frame (2D-Log)');
    
    subplot(2, 2, 4);
    imshow(uint8(predictedFrameThreeStep));
    title('Predicted Frame (Three-Step)');
    
    % Plot motion vectors for 2D-Log
    figure;
    [X, Y] = meshgrid(1:blockSize:width, 1:blockSize:height);
    U = motionVectorsLog(:,:,2);
    V = motionVectorsLog(:,:,1);
    imshow(uint8(frame1));
    hold on;
    quiver(X, Y, U, V, 'r');
    title('Motion Vectors (2D-Log)');
    hold off;
    
    % Plot motion vectors for Three-Step
    figure;
    U = motionVectorsThreeStep(:,:,2);
    V = motionVectorsThreeStep(:,:,1);
    imshow(uint8(frame1));
    hold on;
    quiver(X, Y, U, V, 'r');
    title('Motion Vectors (Three-Step)');
    hold off;
end

% Function to predict the frame based on motion vectors
function predictedFrame = predictFrame(refFrame, motionVectors, blockSize)
    [height, width] = size(refFrame);
    predictedFrame = zeros(height, width);
    
    for i = 1:blockSize:height-blockSize+1
        for j = 1:blockSize:width-blockSize+1
            mv = motionVectors((i-1)/blockSize+1, (j-1)/blockSize+1, :);
            ref_i = i + mv(1);
            ref_j = j + mv(2);
            predictedBlock = refFrame(ref_i:ref_i+blockSize-1, ref_j:ref_j+blockSize-1);
            predictedFrame(i:i+blockSize-1, j:j+blockSize-1) = predictedBlock;
        end
    end
end








% 2D-Logarithmic Search


function motionVectors = logSearch(frame1, frame2, blockSize, searchRange)
    [height, width] = size(frame1);
    motionVectors = zeros(height/blockSize, width/blockSize, 2);

    for i = 1:blockSize:height-blockSize+1
        for j = 1:blockSize:width-blockSize+1
            currentBlock = frame1(i:i+blockSize-1, j:j+blockSize-1);
            bestMAD = inf;
            bestMatch = [0, 0];
            stepSize = searchRange / 2;

            while stepSize >= 1
                for m = -stepSize:stepSize:stepSize
                    for n = -stepSize:stepSize:stepSize
                        ref_i = i + bestMatch(1) + m;
                        ref_j = j + bestMatch(2) + n;
                        if ref_i > 0 && ref_j > 0 && ref_i+blockSize-1 <= height && ref_j+blockSize-1 <= width
                            refBlock = frame2(ref_i:ref_i+blockSize-1, ref_j:ref_j+blockSize-1);
                            mad = sum(sum(abs(double(currentBlock) - double(refBlock))));

                            if mad < bestMAD
                                bestMAD = mad;
                                bestMatch = [bestMatch(1) + m, bestMatch(2) + n];
                            end
                        end
                    end
                end
                stepSize = stepSize / 2;
            end

            motionVectors((i-1)/blockSize+1, (j-1)/blockSize+1, :) = bestMatch;
        end
    end
end



% 3 step search



function motionVectors = threeStepSearch(frame1, frame2, blockSize, searchRange)
    [height, width] = size(frame1);
    motionVectors = zeros(height/blockSize, width/blockSize, 2);

    for i = 1:blockSize:height-blockSize+1
        for j = 1:blockSize:width-blockSize+1
            currentBlock = frame1(i:i+blockSize-1, j:j+blockSize-1);
            bestMAD = inf;
            bestMatch = [0, 0];
            stepSize = floor(searchRange / 2);

            for step = 1:3
                for m = -stepSize:stepSize:stepSize
                    for n = -stepSize:stepSize:stepSize
                        ref_i = i + bestMatch(1) + m;
                        ref_j = j + bestMatch(2) + n;
                        if ref_i > 0 && ref_j > 0 && ref_i+blockSize-1 <= height && ref_j+blockSize-1 <= width
                            refBlock = frame2(ref_i:ref_i+blockSize-1, ref_j:ref_j+blockSize-1);
                            mad = sum(sum(abs(double(currentBlock) - double(refBlock))));

                            if mad < bestMAD
                                bestMAD = mad;
                                bestMatch = [bestMatch(1) + m, bestMatch(2) + n];
                            end
                        end
                    end
                end
                stepSize = ceil(stepSize / 2);
            end

            motionVectors((i-1)/blockSize+1, (j-1)/blockSize+1, :) = bestMatch;
        end
    end
end





