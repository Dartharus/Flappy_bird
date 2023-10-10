class Bar
{
  int holeY;
  int barX;
  int barWidth;
  int holeHeight;
  
  PImage bar;
  
  Bar(int barX)
  {
    this.holeY = 0;
    this.barX = barX;
    this.barWidth = 50;
    this.holeHeight = 150;
    
    bar = loadImage("bar.png");
  }
  
  int getBarX()
  {
    return barX;
  }
  void setBarX(int value)
  {
    barX = value;
  }
  void display()
  {
    //commented code to test actual bar
    /*fill(255, 0, 0);
    rectMode(CORNER);
    rect(barX, 0, barWidth, screenSize);*/
    
    /*fill(0, 255, 0);
    rectMode(CORNER);
    rect(barX + 23, holeY - holeHeight/2, 5, holeHeight);*/
    
    imageMode(CENTER);
    image(bar,barX+25,holeY,60,1250);
    resetBarPos();
  }
  
  boolean collisionDetected()
  {
    boolean collision = false;
    if((ball.getBallX() + ball.getBallDiameter()/2) >= (barX) && (ball.getBallX() - ball.getBallDiameter()/2) < (barX + barWidth))
    {
      if((ball.getBallY() - ball.getBallDiameter()/2 <= holeY - holeHeight/2) || (ball.getBallY() + ball.getBallDiameter()/2 >= holeY + holeHeight/2))               
      {                                                                                                                    
        collision = true;
      }
    }
    else
    {
      collision = false;
    }
    
    return collision;
   }
   
   void resetBarPos()
   {
     if((barX + barWidth) <= -150)
     {
       barX += screenSize + barWidth + 150;
       resetHolePos();
     }
   }
   
   void resetHolePos()
   {
     holeY = (int)random(100,screenSize-150);
   }
   
   void updatePos()
   {
     barX -= 4;
     resetBarPos();
   }
}

