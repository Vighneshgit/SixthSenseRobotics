
% Here are some simple MATLAB codes you can use to test basic functionality and get started:

% 1. Hello World

disp('Hello, World!');

% 2. Simple Arithmetic Operations
% Perform basic math operations:

a = 10;
b = 5;
sum = a + b;
difference = a - b;
product = a * b;
quotient = a / b;
disp(['Sum: ', num2str(sum)]);
disp(['Difference: ', num2str(difference)]);
disp(['Product: ', num2str(product)]);
disp(['Quotient: ', num2str(quotient)]);


% 3. Plot a Simple Graph
% Create a sine wave plot:

x = 0:0.1:10; % Generate values from 0 to 10 in steps of 0.1
y = sin(x);   % Calculate sine of x
plot(x, y);   % Plot the sine wave
xlabel('X-axis');
ylabel('Y-axis');
title('Sine Wave');


% 4. Image Processing Test
% Read and display an image:



img = imread('peppers.png'); % Built-in image in MATLAB
imshow(img);                 % Display the image

Convert the image to grayscale:
grayImg = rgb2gray(img);
imshow(grayImg);




% 6. Simple Conditional Statement
% Check if a number is even or odd:


num = input('Enter a number: ');
if mod(num, 2) == 0
    disp('The number is even.');
else
    disp('The number is odd.');
end


% 7. Simple Loop
% Sum numbers from 1 to 10 using a loop:


sum = 0;
for i = 1:10
    sum = sum + i;
end
disp(['Sum of numbers from 1 to 10: ', num2str(sum)]);


% 8. Real-Time Webcam Preview
% Test if your webcam is working (requires the Image Acquisition Toolbox):


vid = videoinput('winvideo', 1); % Adjust DeviceID as needed
preview(vid); % Preview live feed


% 9. Generate Random Numbers
% Generate a matrix of random numbers:


randomMatrix = rand(3, 3); % 3x3 matrix with random numbers between 0 and 1
disp('Random Matrix:');
disp(randomMatrix);

% 10. Play a Sound
% Generate a sine wave sound:


fs = 44100;          % Sampling frequency
t = 0:1/fs:1;        % Time vector of 1 second
y = sin(2*pi*440*t); % Sine wave at 440 Hz (A4)
sound(y, fs);        % Play the sound