PGraphics textBuffer;
String message = "Kim og Arthur skrive processing!";
float waveAmplitude = 30; // Double the size of the sine wave
float waveFrequency = 0.03;
float scrollSpeed = 1;

void setup() {
  size(800, 200);
  
  // Create a buffer to draw the text off-screen
  textBuffer = createGraphics(width * 2, height);
  textBuffer.beginDraw();
  textBuffer.background(0);
  textBuffer.fill(255);
  textBuffer.textSize(32);
  textBuffer.text(message, 0, height / 2);
  textBuffer.endDraw();
}

void draw() {
  background(0);
  
  loadPixels(); // Load the pixels of the main canvas
  
  // Calculate the wave offset based on time
  float waveOffset = millis() / 1000.0;
  
  // Load the pixels from the text buffer
  textBuffer.loadPixels();
  
  // Apply the pixel wave effect
  for (int x = 0; x < textBuffer.width; x++) {
    for (int y = 0; y < textBuffer.height; y++) {
      int loc = x + y * textBuffer.width;
      
      // Only apply wave to non-black pixels (i.e., the white text)
      if (textBuffer.pixels[loc] != color(0)) {
        // Calculate the new Y position using the sine wave
        float wave = sin(x * waveFrequency + waveOffset) * waveAmplitude;
        int newY = y + int(wave);
        
        // Make sure the new Y position is within the canvas bounds
        if (newY >= 0 && newY < height) {
          int newLoc = x + newY * width;
          pixels[newLoc] = textBuffer.pixels[loc];
        }
      }
    }
  }
  
  updatePixels(); // Update the canvas with the new pixel positions
  
  // Scroll the text buffer to the left
  textBuffer.beginDraw();
  textBuffer.background(0);
  textBuffer.fill(255);
  textBuffer.text(message, -frameCount * scrollSpeed % width, height / 2);
  textBuffer.endDraw();
}
