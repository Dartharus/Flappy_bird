class Background
{
  PImage background;
  PImage ground;
  int x1;
  int x2;
  
  Background()
  {
    background = loadImage("background.png");
    ground = loadImage("ground.png");
    this.x1 = 0;
    this.x2 = 0;
  }
  
  void displayBG()
  {
    background(background);
  }
  
  void displayGround()
  {
    imageMode(CORNER);
    //if ground is supposed "animating"
    if(groundMove == true)
    {
      x1-=4;
      x2-=4;
      if(x1 <= -600)
      {
        x1 = 600;
      }
      if(x2 <= -1200)
      {
        x2 = 0;
      }
      image(ground,x1,screenSize-40);
      image(ground,screenSize + x2,screenSize-40);
    }
    //else stop at current position
    else
    {
      x1 = x1;
      x2 = x2;
      image(ground,x1,screenSize-40);
      image(ground,screenSize + x2,screenSize-40);
    }
  }
}
