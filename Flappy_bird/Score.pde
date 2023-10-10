class Score
{
  int score;
  String[] loadHighscore;
  String[] saveHighscore;
  String checkHighscore;
  int currentHighscore;
  
  Score()
  {
    //read highscore from textfile and store the value
    this.score = 0;
    loadHighscore = loadStrings("Highscore.txt");
    checkHighscore = join(loadHighscore," ");
    currentHighscore = int(checkHighscore);
  }
  
  int getScore()
  {
    return score;
  }
  
  int getHighscore()
  {
    return currentHighscore;
  }
  
  void resetScore()
  {
    score = 0;
  }

  void incrementScore()
  {
    score++;
  }
  
  void updateHighscore()
  {
    saveHighscore = split(str(score),' ');
  }
  
  void saveHighScore()
  {
    //if new highscore save score into text file
    if(score >= currentHighscore)
     {
       saveStrings("Highscore.txt", saveHighscore);
     }
    loadHighscore = loadStrings("Highscore.txt");
    checkHighscore = join(loadHighscore," ");
    currentHighscore = int(checkHighscore);
  }
  
  void display()
  {
    fill(255, 255, 255);
    text(score, screenSize/2 - 5, 40);
  }
}
