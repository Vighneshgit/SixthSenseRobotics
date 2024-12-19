vid = videoinput('winvideo', 1);
i = getsnapshot(vid);
j = i(:, 300:900, :);
imshow(j);
r = j(:, :, 1);
g = j(:, :, 2);
b = j(:, :, 3);
x = sum(sum(r)); % sum of all the red pixels present in the image
y = sum(sum(g)); % sum of all the green pixels present in the image
z = sum(sum(b)); % sum of all the blue pixels present in the image
m = figure;
h = actxcontrol('WMPlayer.OCX.7', [10 10 400 300], m);
if x > y && x > z
    disp('You are holding a red image');
    set(h, 'URL', 'C:\Dashboard\Workshops Courses\Sixth Sense Robotics\Music\01.mp3');
elseif y > x && y > z
    disp('You are holding a green image');
    set(h, 'URL', 'C:\Dashboard\Workshops Courses\Sixth Sense Robotics\Music\02.mp3');
elseif z > x && z > y
    disp('You are holding a blue image');
    set(h, 'URL', 'C:\Dashboard\Workshops Courses\Sixth Sense Robotics\Music\03.mp3');
end
