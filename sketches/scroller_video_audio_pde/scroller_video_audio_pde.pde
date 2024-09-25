import processing.video.*;
import processing.sound.*;

// Paths to the video and audio files
String videoPath = "E:/assets/model-tests/video/CogVideoX-2B/20240811_093912.mp4";
String audioPath = "E:/backup/suno.com/Oooouuuuaaaaaahhhhhhhh!.mp3";

Movie myVideo;
SoundFile myAudio;

PGraphics textBuffer;
String message = "Kim og Arthur skrive processing!";
float waveAmplitude = 40; // Larger sine wave
float waveFrequency = 0.05;
float scrollSpeed = 2;

void setup() {
  size(800, 600);  // Set the size to match your video

  // Load and play the video
  myVideo = new Movie(this, videoPath);
  myVideo.loop();  // Loops the video

  // Load and play the audio
  myAudio = new SoundFile(this, audioPath);
  myAudio.play();  // Plays the audio once

  // Create a buffer for the text to apply the wave effect
  textBuffer = createGraphics(width * 2, height);
  textBuffer.beginDraw();
  textBuffer.background(0, 0);  // Transparent background
  textBuffer.fill(255);
  textBuffer.textSize(32);
  textBuffer.text(message, 0, height / 2);
  textBuffer.endDraw();
}

void draw() {
  // Display the video in the background
  image(myVideo, 0, 0, width, height);

  // Prepare to manipulate pixels for the scrolling text wave effect
  loadPixels();  // Load canvas pixels
  
  float waveOffset = millis() / 1000.0;  // Use time to animate the wave

  // Load text buffer pixels for wave effect
  textBuffer.loadPixels();
  
  // Apply wave effect on the text pixels
  for (int x = 0; x < textBuffer.width; x++) {
    for (int y = 0; y < textBuffer.height; y++) {
      int loc = x + y * textBuffer.width;
      
      // Only apply wave to non-transparent pixels (text pixels)
      if (textBuffer.pixels[loc] != color(0, 0, 0, 0)) {
        float wave = sin(x * waveFrequency + waveOffset) * waveAmplitude;
        int newY = y + int(wave);
        
        if (newY >= 0 && newY < height) {
          int newLoc = x + newY * width;
          pixels[newLoc] = textBuffer.pixels[loc];
        }
      }
    }
  }

  updatePixels();  // Apply the pixel manipulation

  // Scroll the text buffer to the left
  textBuffer.beginDraw();
  textBuffer.background(0, 0);  // Transparent background
  textBuffer.fill(255);
  textBuffer.text(message, -frameCount * scrollSpeed % width, height / 2);
  textBuffer.endDraw();
}

// Needed to handle video frames
void movieEvent(Movie m) {
  m.read();
}
