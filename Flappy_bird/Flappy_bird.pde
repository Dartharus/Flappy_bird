import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

int screenSize=600;
boolean birdDie = false;
boolean gameStart = false;
boolean gameOver = false;
boolean groundMove = false;
Ball ball;
Bar bar1;
Bar bar2;
Bar bar3;
Bar bar4;
Background Bg;
Score score;
MainMenu menu;
GameOverScreen gameOverScreen;
//Sound sound;
Minim minim;
AudioPlayer bgm;
AudioPlayer flap;
AudioPlayer die;
AudioPlayer point;
boolean bgmPlaying = false;
boolean soundMuted = false;
int FADE = 1;
int readyCounter = 30;

PFont text;
PImage notmute;
PImage mute;

void settings()
{
  size(screenSize,screenSize);
}

void setup()
{
  //initialise classes and load files
  ball = new Ball(1,30);
  bar1 = new Bar(300 + screenSize);
  bar2 = new Bar(500 + screenSize);
  bar3 = new Bar(700 + screenSize);
  bar4 = new Bar(900 + screenSize);
  Bg = new Background();
  score = new Score();
  menu = new MainMenu();
  gameOverScreen = new GameOverScreen();
  //sound = new Sound();
  minim = new Minim(this);
  bgm = minim.loadFile("bgm.mp3");
  flap = minim.loadFile("flap.wav");
  die = minim.loadFile("die.wav");
  point = minim.loadFile("point.wav");
  text = loadFont("8BITWONDERNominal-48.vlw");
  notmute = loadImage("notmute.png");
  mute = loadImage("mute.png");
  textFont(text);
  settings();
  frameRate(30);
  noStroke();
  textSize(32);
  //intialise starting positions
  resetPositions();
  //start background music, pause because game has not started yet
  bgm.play();
  bgm.pause();
}

void draw()
{
  Bg.displayBG();
  if(gameStart == false)
  {
    //menu screen
    menu.display();
    Bg.displayGround();
    groundMove = false;
  }
  else if(gameOver == true)
  {
    //game over screen
    groundMove = false;
    bar1.display();
    bar2.display();
    bar3.display();
    bar4.display();
    Bg.displayGround();
    ball.display();
    gameOverScreen.display();
  }
  else
  {
    //gameplay screen
    runGame();
  }
  //speaker icon
  imageMode(CENTER);
  if(soundMuted == false)
  {
    image(notmute, 575, 25, 25,25);
  }
  else
  {
    image(mute, 575, 25, 25,25);
  }
  
}

void runGame()
{
  readyCounter--;
  if(readyCounter <= 0)
  {
    readyCounter = 0;
  }
  if(bgmPlaying == false)
  {
    bgm.loop();
    bgmPlaying = true;
  }
  //display objects
  bar1.display();
  bar2.display();
  bar3.display();
  bar4.display();
  Bg.displayGround();
  ball.display();
  score.display();
  score.updateHighscore();
  
  if(readyCounter != 0)
  {
    fill(0, 0, 0, readyCounter*9);
    text("get ready", 195, 200);
    text("spacebar", 200, 300);
    text("to flap", 210, 400);
  }
  
  if(birdDie == false)
  {
    //update the bar posisitons
    groundMove = true;
    bar1.updatePos();
    bar2.updatePos();
    bar3.updatePos();
    bar4.updatePos();
  }
  
  // detect collisions between bird and bar
  if ((bar1.collisionDetected() || bar2.collisionDetected() || bar3.collisionDetected() || bar4.collisionDetected() || ((ball.getBallY() + ball.getBallDiameter()/2) >= (screenSize-50))) && birdDie == false)
  {
    birdDie = true;
    groundMove = false;
    playDieSFX();
    bgm.pause();
  }
  //detect collisions between bird and ground
  if(birdDie == true && (ball.getBallY() + ball.getBallDiameter()/2) >= (screenSize-50))
  {
    ball.setBallY(screenSize-(50 + ball.getBallDiameter()/2));
    gameOver = true;
    bgmPlaying = false;
    score.saveHighScore();
  }

  // update ball position
  if(readyCounter == 0)
  {
    ball.ballGravity();
  }

  // update score and reset if necessary
  if(ball.getBallX() >= (bar1.getBarX() +22) && ball.getBallX() <= bar1.getBarX() + 24 ||
     ball.getBallX() >= (bar2.getBarX() +22) && ball.getBallX() <= bar2.getBarX() + 24 ||
     ball.getBallX() >= (bar3.getBarX() +22) && ball.getBallX() <= bar3.getBarX() + 24 ||
     ball.getBallX() >= (bar4.getBarX() +22) && ball.getBallX() <= bar4.getBarX() + 24)
  {
    score.incrementScore();
    playPointSFX();
  }
}
// reset the bar and hole positions
void resetPositions()
{
  bar1.setBarX(300 + screenSize);
  bar2.setBarX(500 + screenSize);
  bar3.setBarX(700 + screenSize);
  bar4.setBarX(900 + screenSize);
  bar1.resetHolePos();
  bar2.resetHolePos();
  bar3.resetHolePos();
  bar4.resetHolePos();
  ball.resetBall(1);
}

void playFlapSFX()
{
  flap.rewind();
  flap.play();
}
void playDieSFX()
{
  die.rewind();
  die.play();
}
void playPointSFX()
{
  point.rewind();
  point.play();
}
boolean getGroundMoveState()
{
  return groundMove;
}

// handle keyboard input
void keyPressed()
{
  if (key == ' ' && birdDie == false && readyCounter == 0)
  {
    ball.ballFly();
    playFlapSFX();
  }
  if (key == ENTER && gameStart == false)
  {
    gameStart = true;
    resetPositions();
  }
  if (key == ENTER && gameOver == true)
  {
    gameStart = false;
    gameOver = false;
    birdDie = false;
    readyCounter = 30;
    score.resetScore();
  }
  if (key == 'm' || key == 'M')
  {
    if(soundMuted == false)
    {
      bgm.mute();
      flap.mute();
      die.mute();
      point.mute();
      soundMuted = true;
    }
    else
    {
      bgm.unmute();
      flap.unmute();
      die.unmute();
      point.unmute();
      soundMuted = false;
    }
  }
  
  if (key == ESC && gameStart == false)
  {
    key = 0;
    exit();
  }
  else
  {
    key = 0;
  }
}
//handle mouse input
void mousePressed()
{
  if(mouseX >= 75 && mouseX <= 275 && mouseY >= 363 && mouseY <= 437 && gameStart == false)    //clciked left main menu button
  {
    gameStart = true;
    resetPositions();
  }
  if(mouseX >= 325 && mouseX <= 525 && mouseY >= 363 && mouseY <= 437 && gameStart == false)    //clciked right main menu button
  {
    exit();
  }
  
  if(mouseX >= 136 && mouseX <= 464 && mouseY >= 358 && mouseY <= 440 && gameOver == true)
  {
    gameStart = false;
    gameOver = false;
    birdDie = false;
    readyCounter = 30;
    score.resetScore();
  }
  if(mouseX >= 560 && mouseX <= 585 && mouseY >= 10 && mouseY <= 40)
  {
    if(soundMuted == false)
    {
      bgm.mute();
      flap.mute();
      die.mute();
      point.mute();
      soundMuted = true;
    }
    else
    {
      bgm.unmute();
      flap.unmute();
      die.unmute();
      point.unmute();
      soundMuted = false;
    }
  }
}























