% Initialize webcam
vid = videoinput('winvideo');
set(vid, 'FramesPerTrigger', Inf);
set(vid, 'ReturnedColorspace', 'rgb');
start(vid);

while true
    frame = getsnapshot(vid); % Capture frame
    grayFrame = rgb2gray(frame); % Convert to grayscale
    filteredFrame = imgaussfilt(grayFrame, 2); % Apply Gaussian filter
    edges = edge(filteredFrame, 'Canny'); % Perform edge detection
    imshow(edges);
    
    % Exit with key press
    if ~isempty(get(gcf, 'CurrentCharacter'))
        break;
    end
end
stop(vid);
delete(vid);
clear vid;
