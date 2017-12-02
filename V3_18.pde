/*Chill Billiards, a game created by Nathan Moton in late 2016. To see various changes from V3.0,
and onwards, see "Change_Log.txt"*/

//Importing various sound effects.
import ddf.minim.*;
Minim minim;

//Sound effect for when the cue ball is hit with the cue stick.
AudioPlayer sound_cue;

//Sound effect for when balls collide.
AudioPlayer balls_hit;

//Importing custom images for the game with appropriate names.
PImage background;
PImage title;
PImage lose;
PImage win;

//Initializing the variables for sound.
int start_time, duration, time;

//Setting the initial game mode to 0. 
int gamemode = 0;

//Creating a new object of class table. Object table contains all variables 
Table table = new Table ();

//Radius for all balls.
float rad = 25;

//Friction for all balls.
float friction = 0.03;

//Creating a new object of class Motion. This object will manage the movement of the cue bll. It is seperate from the movement function
//of the other balls as it is controlled by user interaction.
CueBallMovement CueBallMotion = new CueBallMovement (table.cue_ball.center.x, table.cue_ball.center.y);

void setup()
{
  size (800, 800);
  frameRate(70);
  
  background = loadImage("Dark-Wood-Background.jpg");
  title = loadImage("TitlePage.png");
  lose = loadImage("Gameover.png");
  win = loadImage("YouWin.png");
  minim = new Minim(this);
  sound_cue = minim.loadFile ("Sound1.mp3", 2048);
  balls_hit = minim.loadFile ("BallsHit.mp3");
  
  start_time = millis();
  time = duration = 120;
  
    for (int i = 0; i < table.b_arr.length; i++)
  {
    table.b_arr[i] = new Ball (table.b_arrLocationX[i], table.b_arrLocationY[i], rad);
  }
}

void draw()
{
  if (gamemode == 0) //The title screen.
  {
   image(title, 0, 0);
  }
  
  if (gamemode == 2) //The game is currently active.
  {
    move_ball();
    
    //Two for loops that will send the balls to collision_engine for physics and movement calculations.
    for (int i = 0; i < table.b_arr.length; i++)
     {
      collision_engine (table.cue_ball, table.b_arr[i]);
      for (int j = 0; j < table.b_arr.length; j++)
       {
        if (j != i)
         {
          collision_engine (table.b_arr[i], table.b_arr[j]);
         }
        }
      }
   draw_table();
   draw_ball();
   game_over();
   remove_balls();
   timer();
  }

  if (gamemode == 3) //The player has lost the game.
    {
     image(lose, 0, 0);
    }
    
  if (gamemode == 4) //The player has won the game.
   {
    image(win, 0, 0);
   }
}