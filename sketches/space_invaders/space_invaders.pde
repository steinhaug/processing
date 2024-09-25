int rows = 6;
int cols = 8;
int invaderSize = 30;
int playerSize = 50;
int bulletSize = 5;
int playerX;
int playerY;
int bulletX, bulletY;
boolean bulletFired = false;
boolean[][] invaders = new boolean[rows][cols];
float[] invaderX = new float[cols];
float invaderY = 50;
float invaderSpeed = 2;
boolean moveRight = true;

void setup() {
  size(600, 600);
  playerX = width / 2;
  playerY = height - 50;
  
  // Initialize invaders
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      invaders[i][j] = true; // Set all invaders as alive
      invaderX[j] = j * (invaderSize + 10) + 40;
    }
  }
}

void draw() {
  background(0);
  
  // Draw player
  fill(0, 255, 0);
  rect(playerX, playerY, playerSize, playerSize / 2);
  
  // Move and draw invaders
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      if (invaders[i][j]) {
        fill(255, 0, 0);
        rect(invaderX[j], invaderY + i * (invaderSize + 10), invaderSize, invaderSize);
      }
    }
  }
  
  // Move invaders
  if (moveRight) {
    for (int i = 0; i < cols; i++) {
      invaderX[i] += invaderSpeed;
    }
    if (invaderX[cols - 1] + invaderSize > width) {
      moveRight = false;
      invaderY += 20;
    }
  } else {
    for (int i = 0; i < cols; i++) {
      invaderX[i] -= invaderSpeed;
    }
    if (invaderX[0] < 0) {
      moveRight = true;
      invaderY += 20;
    }
  }
  
  // Move bullet
  if (bulletFired) {
    bulletY -= 5;
    fill(255, 255, 0);
    ellipse(bulletX, bulletY, bulletSize, bulletSize);
    
    // Check for bullet collision with invaders
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        if (invaders[i][j]) {
          float invaderLeft = invaderX[j];
          float invaderRight = invaderX[j] + invaderSize;
          float invaderTop = invaderY + i * (invaderSize + 10);
          float invaderBottom = invaderTop + invaderSize;
          
          if (bulletX > invaderLeft && bulletX < invaderRight && bulletY > invaderTop && bulletY < invaderBottom) {
            invaders[i][j] = false;
            bulletFired = false;
          }
        }
      }
    }
    
    // Reset bullet if it leaves the screen
    if (bulletY < 0) {
      bulletFired = false;
    }
  }
}

void keyPressed() {
  if (keyCode == LEFT) {
    playerX -= 10;
  } else if (keyCode == RIGHT) {
    playerX += 10;
  } else if (key == ' ' && !bulletFired) {
    bulletX = playerX + playerSize / 2;
    bulletY = playerY;
    bulletFired = true;
  }
}
