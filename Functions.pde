/*The function 'draw_table' will draw the brown outer layer of the table, the green playing section of the table, 
and the four holes of the pool table.

REQUIRES:
- The location data and dimensions of the brown outer layer, the green playing section, and the size of the pockets
of the table; this data is stored all in the object of type Table named 'table.'
- A background image.

PROMISES:
- Displaying the brown outer layer, green playing section, and black pockets all with their respective dimensions,
and locations.
- Displays the background image.
*/
void draw_table()
{
  //Displaying the background image.
  image(background, 0, 0);
  
  rectMode (CENTER);
  //Location of the brown section of the table.
  fill (102, 51, 0);
  rect (table.tableLocation, table.tableLocation, table.playingL + 75, table.playingW + 75, table.tableEdges, table.tableEdges, table.tableEdges, table.tableEdges);
  
  //Location of the green playing section of the table.
  fill (0, 125, 0);
  rect (table.tableLocation, table.tableLocation, table.playingL, table.playingW, table.tableEdges, table.tableEdges, table.tableEdges, table.tableEdges);
  
  //Location and drawing of the holes.
  fill (0);
  ellipse (table.holeLeftLocation, table.holeUpperLocation, table.holeRad, table.holeRad);
  ellipse (table.holeRightLocation, table.holeUpperLocation, table.holeRad, table.holeRad);
  ellipse (table.holeLeftLocation, table.holeLowerLocation, table.holeRad, table.holeRad);
  ellipse (table.holeRightLocation, table.holeLowerLocation, table.holeRad, table.holeRad);
}

/* Function 'draw_ball' will display the cue ball, pool cue, and balls based on their location, size and color data stored in the object 'table'
of class Table. The function calls and uses all the relevant data stored in the object 'table'. The function will also display the stick, and
change its length depending on the distance of the mouse cursor when clicked.

REQUIRES:
- Location, size, and color data from the object 'table' of class Table.
- Human interaction in the form of a mouse click to sketch the pool cue.

PROMISES:
- Displays the cue ball, balls, and pool cue.
*/
void draw_ball()
{
  ellipseMode(CENTER);
  fill (table.cue_ball.col);
  ellipse (table.cue_ball.center.x, table.cue_ball.center.y, rad, rad);
  
  table.st = new Stick(table.cue_ball.center.x, table.cue_ball.center.y, 0, 0, 0);
  
  //if statement that determines the length of the pool cue based on the distance between the center of the cue ball and mouse cursor.
  //The pool cue is only displayed if the mouse is pressed down.
  if (mousePressed == true)
  {
   strokeWeight(4);
   fill(table.st.col);
   line(table.st.start_p.x, table.st.start_p.y, table.st.end_p.x, table.st.end_p.y);
   strokeWeight(1);
  }
  
  //for loop that will display every single ball in the array of type Ball 'b_arr' that is being stored in the object of
  //type Table named 'table.' The for loop will also display the color of the balls using the RGB values stored in the 2D array
  //named 'b._arrCol'.
  for (int i = 0; i < table.b_arr.length; i++)
  {
    fill (table.b_arrCol[i][0], table.b_arrCol[i][1], table.b_arrCol[i][2]);
    ellipse (table.b_arr[i].center.x, table.b_arr[i].center.y, rad, rad);
   }
}

/*The function 'mouseReleased' will call on the function 'acceleration' that is within the object of type 'CueBallMovement'
named 'CueBallMotion.' The function will send the x and y location of the cue ball at the moment it is called (when the mouse
is released. After sending the x and y location of the cue ball, and processing the acceleration of the cue ball, the function
will then call the acceleration of the cue ball from the object 'CueBallMotion' and store it in powerX and powerY. The function
will then play the pool cue sound effects.

REQUIRES:
- Human interaction in the form of a mouse release.
- The location of the cue ball.

PROMISES:
- To send the location of the cue ball to the 'acceleration' function found within object 'CueBallMotion' to process the
acceleration.
- To store the processed acceleration in the powerX and powerY variables of the cue ball.
*/
void mouseReleased()
{
  CueBallMotion.acceleration(table.cue_ball.center.x, table.cue_ball.center.y);
  table.cue_ball.powerX = CueBallMotion.accelerationX;
  table.cue_ball.powerY = CueBallMotion.accelerationY;
  
  sound_cue.rewind();
  sound_cue.play();
}

//The function 'keyPressed' contains the various reactions to key presses for the 'gamemode's.

void keyPressed()
{
  if (gamemode == 0)
    gamemode = 1;
  if (gamemode == 1)
    gamemode = 2;
  if (gamemode == 3)
  {
    gamemode = 0;
    restartGame();
  }
  if (gamemode == 4)
  {
    gamemode = 0;
    restartGame();
  }
}

/*The function 'game_over' will activate when the cue ball enters one of the pockets. It will set the 'gamemode' to 3.

REQUIRES:
- Location of the cue ball.
- Location of the pockets

PROMISES:
- To change the 'gamemode' to 3 if the cue ball enters the pockets.
*/
void game_over()
{
  if ((table.cue_ball.center.x <= 120 && (table.cue_ball.center.y <= 270 || table.cue_ball.center.y >= 535)) 
  || ((table.cue_ball.center.x >= 680 && (table.cue_ball.center.y <= 270 || table.cue_ball.center.y >= 535))))
      {
        gamemode = 3;
      }
}

/* The function 'remove_balls' will activate when balls in the array of type Ball 'b_arr' stored in the object 'table' of type
Table enters the pockets. The ball that has fallen into the pocket will be moved to a location that cannot be seen on the
screen. This function also delcares a variable of type int named 'score.' If a ball has fallen into a pocket, the value of
'score' will increase by one.

REQUIRES:
- Location data of the balls in the array 'b_arr'
- Location of the pockets.

PROMISES: 
- To move the balls that have fallen into the pockets to an off-screen location.
- To increas the value of 'score' by one.

*/
void remove_balls()
{
  int score = 0;
  for (int i = 0; i < table.b_arr.length; i++)
  {
   if ((table.b_arr[i].center.x <= 120 && (table.b_arr[i].center.y <= 270 || table.b_arr[i].center.y >= 535)) 
   || ((table.b_arr[i].center.x >= 680 && (table.b_arr[i].center.y <= 270 || table.b_arr[i].center.y >= 535))))
      {
        table.b_arr[i].center.x = 900;
        table.b_arr[i].center.y = 900;
        
        score++;
      }
  }
  
  //This if statement will change the 'gamemode' to 4 if 'score' reaches 6. 'score' will reach 6 if all balls are
  //in the pockets.
  if (score == 6)
  gamemode = 4;
  
  //The value in 'score' will be sent to the function 'displayScore'
  displayScore(score);
}

/*The function 'move_ball' will take the location of the cue ball and balls, and add their power to their location. The
function will also check for collisions with the walls. The power of the ball will then be reduced even more, and will
be subtracted from the location of the ball. This will slow down the ball, and eventually make it stop. If a ball collides with the wall, 
the power will be decreased more, causing the ball to slow down even more. When a ball collides with a wall, a sound effect will activate.

REQUIRES:
- Location of the balls.
- Power values of the balls.
- Sound effects.

PROMISES:
- To move the balls by changing their location by adding and subtracting their power values.
- To play sound effects.
- To slow down and eventually stop the balls from moving.
*/
void move_ball()
{
 if (table.cue_ball.center.x >= 687.5 || table.cue_ball.center.x <= 112.5)
  {
   table.cue_ball.powerX *= -0.95;
   sound_cue.rewind();
   sound_cue.play();
  }
  
 if (table.cue_ball.center.y >= 537.5 || table.cue_ball.center.y <= 262.5)
  {
   table.cue_ball.powerY *= -0.95;
   sound_cue.rewind();
   sound_cue.play();
  }
  table.cue_ball.center.x += table.cue_ball.powerX;
  table.cue_ball.center.y += table.cue_ball.powerY;
  table.cue_ball.powerX -= (table.cue_ball.powerX * 0.0115);
  table.cue_ball.powerY -= (table.cue_ball.powerY * 0.0115);
    
 for (int i = 0; i < table.b_arr.length; i++)
  {
   if (table.b_arr[i].center.x >= 687 || table.b_arr[i].center.x < 113)
   {
     table.b_arr[i].powerX *= -1;
     sound_cue.rewind();
     sound_cue.play();
   }
   
   if (table.b_arr[i].center.y >= 537 || table.b_arr[i].center.y <= 263)
   {
    table.b_arr[i].powerY *= -1;
    sound_cue.rewind();
    sound_cue.play();
   }
    table.b_arr[i].center.x += table.b_arr[i].powerX;
    table.b_arr[i].center.y += table.b_arr[i].powerY;
    table.b_arr[i].center.x += table.b_arr[i].powerX * 0.0115;
    table.b_arr[i].center.y += table.b_arr[i].powerY * 0.0115;
    table.b_arr[i].powerX -= (table.b_arr[i].powerX * 0.0115);
    table.b_arr[i].powerY -= (table.b_arr[i].powerY * 0.0115);
   }
}

/* The function 'collision_engine' will manage the collisions of the balls. A collision is detected if the distance of
the certain balls being checked is less than the radius of the balls. When a collision is detected, the power is reduced. The
new power of the balls are calculated by 'collisionFraction', which is a mathematical equation taken from the ENGG 233 collision
explanation sheet. The function will take the power values and location of the balls based on the two objects of type Ball
that are sent to it, check if they have collided, apply the values to a mathematical equation, and then change the power values
of the balls respectively.

REQUIRES:
- Location of the balls.
- Power values of the balls.
- The Power and the Location of the balls can be found in the objects of Type Ball that are sent.
- Two objects of type Ball.

PROMISES:
- New power values for the balls that simulate a collision after a collision has been detected.
*/
void collision_engine (Ball x, Ball y) 
{
 if (dist (x.center.x, x.center.y, y.center.x, y.center.y) < rad)
 {
  balls_hit.rewind();
  balls_hit.play();
  x.center.x -= x.powerX;
  x.center.y -= x.powerY;
  y.center.x -= y.powerX;
  y.center.y -= y.powerY;
  float numerator = ((x.powerX - y.powerX) * (x.center.x - y.center.x) + (x.powerY - y.powerY) * (x.center.y - y.center.y));
  float denominator = ((x.center.x - y.center.x) * (x.center.x - y.center.x) + (x.center.y - y.center.y) * (x.center.y - y.center.y));
  float collisionFraction = numerator/denominator;
  x.powerX = x.powerX - collisionFraction * (x.center.x - y.center.x);
  x.powerY = x.powerY - collisionFraction *(x.center.y - y.center.y);
  y.powerX = y.powerX + collisionFraction *(x.center.x - y.center.x);
  y.powerY = y.powerY + collisionFraction *(x.center.y - y.center.y);
  }
}

//Function 'restartGame' will reset the location of the balls, time, and power of the cue ball.
void restartGame()
{
    for (int i = 0; i < table.b_arr.length; i++)
  {
    table.b_arr[i] = new Ball (table.b_arrLocationX[i], table.b_arrLocationY[i], rad);
    table.b_arr[i].powerX = 0;
    table.b_arr[i].powerY = 0;
  }
  table.cue_ball.center.x = 200;
  table.cue_ball.center.y = 400;
  table.cue_ball.powerX = 0;
  table.cue_ball.powerY = 0;
  
  start_time = 120;
  time = duration = 120;
}

/*Function 'displayScore' will display the number of balls sunk.

REQUIRES:
- Score value to display

PROMISES:
- To display the score on the top left of the game window.
*/
  void displayScore(int x)
{
  fill (255);
  textSize (20);
  text("Score (Balls sunk)", 10, 100);
  text(x, 10, 120);
}

//Function 'timer' will display the time remaining in the game. If the time hits 0, 'gamemode' will be changed
//to 3.
void timer()
{
 if (time > 0)
 {
   time = duration - (millis() - start_time)/1000;
   textSize(20);
   fill(255);
   text(time, 200, 100);
 }
 
 if (time == 0)
 {
   gamemode = 3;
 }
}