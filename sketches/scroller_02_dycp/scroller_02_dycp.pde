PFont monoFont;
String message = "Kim og Arthur skrive processing! ";
float x; // X position for the scrolling text
float waveAmplitude = 20; // How high the wave effect should go
float waveFrequency = 0.05; // Frequency of the wave

void setup() {
  size(800, 200);
  monoFont = createFont("Courier", 32); // Use a monospaced font like Courier
  textFont(monoFont);
  x = width;
}

void draw() {
  background(0);  // Black background
  fill(255);      // White text
  
  float waveOffset = millis() / 1000.0; // Use time to animate the wave
  
  for (int i = 0; i < message.length(); i++) {
    char c = message.charAt(i);
    
    // Calculate x position for each character (with monospaced font)
    float charX = x + i * textWidth(' ');  // Use space ' ' width as a fixed width for all characters
    
    // Calculate wave effect using sin()
    float charY = height / 2 + sin(charX * waveFrequency + waveOffset) * waveAmplitude;
    
    // Draw character at its position with wave effect
    text(c, charX, charY);
  }
  
  // Scroll the text to the left
  x -= 2;
  
  // Reset x when the entire message has scrolled off-screen
  if (x < -textWidth(message)) {
    x = width;
  }
}
