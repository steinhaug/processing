String message = "Kim og Arthur skrive processing! ";
float x; // X position for the scrolling text
float waveAmplitude = 20; // How high the wave effect should go
float waveFrequency = 0.05; // Frequency of the wave

void setup() {
  size(800, 200);
  textSize(32);  // You can use any font you like
  x = width;
}

void draw() {
  background(0);  // Black background
  fill(255);      // White text
  
  float waveOffset = millis() / 1000.0; // Use time to animate the wave
  
  float currentX = x; // Variable to track cumulative x position
  
  for (int i = 0; i < message.length(); i++) {
    char c = message.charAt(i);
    
    // Calculate wave effect using sin()
    float charY = height / 2 + sin(currentX * waveFrequency + waveOffset) * waveAmplitude;
    
    // Draw character at its position with wave effect
    text(c, currentX, charY);
    
    // Update currentX to the next character's position (accounting for variable width)
    currentX += textWidth(c);
  }
  
  // Scroll the text to the left
  x -= 2;
  
  // Reset x when the entire message has scrolled off-screen
  if (x < -textWidth(message)) {
    x = width;
  }
}
