class Ball
{
  int ballX;
  int ballY;
  float ballInc;
  int ballDiameter;
  float gravity;
  float maxSpeed;
  float angle;
  boolean flap;
  int animationFrame;
  
  PImage imgs[];
  
  Ball(float ballInc, int ballDiameter)
  {
    this.ballX = 100;
    this.ballY = 300;
    this.ballInc = ballInc;
    this.ballDiameter = ballDiameter;
    this.gravity = 1;
    this.maxSpeed = 10;
    this.angle = 0;
    this.flap = false;
    this.animationFrame = 0;

    imgs = new PImage[4];
    imgs[0] = loadImage("bird1.png");
    imgs[1] = loadImage("bird2.png");
    imgs[2] = loadImage("bird3.png");
    imgs[3] = loadImage("bird2.png");
  }
  
  int getBallX()
  {
    return ballX;
  }
  
  int getBallY()
  {
    return ballY;
  }
  
  void setBallY(int value)
  {
    ballY = value;
  }
  
  int getBallDiameter()
  {
    return ballDiameter;
  }
  
  void resetBall(int value)
  {
    ballX = 100;
    ballY = 300;
    ballInc = value;
    angle = 0;
  }
  
  void display()
  {
    // draw ball
    imageMode(CENTER);
    pushMatrix();
    translate(ballX,ballY);
    if(readyCounter == 0)
    {
      if(flap == true)
      {
        angle -= 90;
        if(angle <= 45)
        {
          angle = -45;
        }
      }
      else
      {
        angle += 9;
      }
      if(angle >= 90)
      {
        angle = 90;
      }
      rotate(radians(angle));
    }
    if(birdDie == true)
    {
      image(imgs[1],0,0,45,35);
    }
    else
    {
      birdAnimation(0,0);
    }
    popMatrix();
    //commented code for testing actual ball
    //fill(255, 255, 255, 255);
    //ellipse(ballX, ballY, ballDiameter, ballDiameter);
  }
  //apply gravity to the ball
  void ballGravity()
  {
    ballInc += gravity;
    if(ballInc > maxSpeed)
    {
      ballInc = maxSpeed;
    }
    if(ballInc < -7 && flap == false)
    {
      ballInc = -7;
    }
    ballY += ballInc;
    flap = false;
  }
  
  void ballFly()
  {
    flap = true;
    ballInc -= 25;
  }
  
  void birdAnimation(int x, int y)
  {
    if(frameCount % 5 == 0)
    {
      if(animationFrame == 3)
      {
        animationFrame = -1;
      }
      animationFrame++;
    }
    image(imgs[animationFrame], x, y, 45,35);
  }
  
  void resetBallPos()
  {
    ballX=(int)random(screenSize);
    ballY=0;
  }
}
