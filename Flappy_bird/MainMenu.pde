class MainMenu
{
  PImage button;
  PImage title;
  
  MainMenu()
  {
    button = loadImage("button.png");
    title = loadImage("title.png");
  }
  void display()
  {
    fill(0);
    imageMode(CENTER);
    image(title, 300, 200, 300,100);
    //if mouse over button draw white outline
    if(mouseX >= 75 && mouseX <= 275 && mouseY >= 363 && mouseY <= 437)
    {
      fill(255);
      rect(72, screenSize/2 + 58, 206, 82);
    }
    fill(0);
    image(button, screenSize/2 -125, screenSize/2 + 100, 200, 75); //left side 175 right side 325
    text("start", screenSize/2 - 200, screenSize/2 + 112);
    //if mouse over button draw white outline
    if(mouseX >= 325 && mouseX <= 525 && mouseY >= 363 && mouseY <= 437)
    {
      fill(255);
      rect(322, screenSize/2 + 58, 206, 82);
    }
    fill(0);
    image(button, screenSize/2 +125, screenSize/2 + 100, 200, 75);
    text("quit", screenSize/2 + 75, screenSize/2 + 112);
  }
}
