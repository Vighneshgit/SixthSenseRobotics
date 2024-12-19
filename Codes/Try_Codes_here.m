% Initialize video object
vid = videoinput('winvideo', 1);

% Set video properties
set(vid, 'FramesPerTrigger', 1);
set(vid, 'TriggerRepeat', Inf);
vid.FrameGrabInterval = 5;

% Start video acquisition
start(vid);

% Display and process video frames
figure;
while (vid.FramesAcquired <= 100)
    data = getsnapshot(vid);
    grayFrame = rgb2gray(data); % Convert to grayscale
    imshow(grayFrame);
    title('Grayscale Video');
end

% Stop video
stop(vid);
