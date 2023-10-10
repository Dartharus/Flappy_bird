class GameOverScreen
{
  PImage button;
  
  GameOverScreen()
  {
    button = loadImage("button.png");
  }
  
  void display()
  {
    fill(222,216,149);
    rect(130,150,340,300);
    fill(0, 0, 0);
    text("Score   " + score.getScore(), screenSize/2 - 115, screenSize/2 - 75);
    text("Best    " + score.getHighscore(), screenSize/2 - 115, screenSize/2 + 25);
    //if mouse over button draw white outline
    if(mouseX >= 136 && mouseX <= 464 && mouseY >= 358 && mouseY <= 440)
    {
      fill(255);
      rect(132,358,336,82);
    }
    fill(0);
    image(button,screenSize/2,screenSize/2 + 100,328,75);
    text("Main Menu", screenSize/2 - 140, screenSize/2 + 112);
  }
}
