% Ball Tracker by - Vighnesh Shinde 2020
% Ensure you have the correct COM port for the Arduino
arduinoObj = serialport('COM5', 9600); % Update with your Arduino's COM port

% Initialize webcam
vid = videoinput('winvideo', 1, 'MJPG_640x360');
set(vid, 'ReturnedColorspace', 'rgb');
%set(vid, 'FramesPerTrigger', Inf);
set(vid, 'FramesPerTrigger', 1, 'TriggerRepeat', Inf, 'FrameGrabInterval', 1);
set(vid, 'Timeout', 10);  % Set a timeout of 10 seconds
start(vid);

frameCenter = [320, 240]; % Assuming 640x480 resolution
margin = 50; % Threshold margin around the center

figure;
while ishandle(gca)
    % Capture frame
    frame = getsnapshot(vid);
    hsvFrame = rgb2hsv(frame); % Convert to HSV

    % Detect red color
    redMask = (hsvFrame(:,:,1) > 0.95 | hsvFrame(:,:,1) < 0.05) & ...
              (hsvFrame(:,:,2) > 0.5) & (hsvFrame(:,:,3) > 0.5);

    % Remove noise
    redMask = bwareaopen(redMask, 300); % Remove small objects

    % Find the centroid of the red object
    stats = regionprops(redMask, 'Centroid');

    % Visualize the frame
    imshow(frame);
    hold on;
    if ~isempty(stats)
        centroid = stats(1).Centroid;
        plot(centroid(1), centroid(2), 'bo', 'MarkerSize', 10, 'LineWidth', 2);

        % Calculate displacement from center
        dx = centroid(1) - frameCenter(1);
        dy = centroid(2) - frameCenter(2);

        % Determine direction and send serial values
        if abs(dx) < margin && abs(dy) < margin
            % Ball is near the center, do nothing
            disp('Ball is centered');
            write(arduinoObj, 'S', 'char'); % Stops
        elseif abs(dy) > abs(dx)
            if dy < -margin
                write(arduinoObj, 'F', 'char'); % Upwards
                disp('Ball moving up');
            elseif dy > margin
                write(arduinoObj, 'B', 'char'); % Downwards
                disp('Ball moving down');
            end
        else
            if dx > margin
                write(arduinoObj, 'L', 'char'); % Rightwards
                disp('Ball moving left');
            elseif dx < -margin
                write(arduinoObj, 'R', 'char'); % Leftwards
                disp('Ball moving right');
            end
        end
    else
        disp('No red object detected');
    end
    hold off;

    pause(0.1); % Adjust loop speed as necessary
end

if waitforbuttonpress  % This checks if any key is pressed
    % Stop the video and clear the video object if key is pressed
    stop(vid);
    clear vid;
    disp('Video capture stopped and resources cleared.');
end

% Cleanup
stop(vid);
delete(vid);
clear vid;
clear arduinoObj;