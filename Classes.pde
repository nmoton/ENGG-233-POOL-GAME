/*The class Point will be used to manage the location data (coordinates) of the balls, cue ball, and pool cue/stick. 
The location data will be stored in multiple objects of class Point.

REQUIRES:
Two floats to act as an x and y coordinate. If there is are no floats provided, default floats of value 0 will be used as default.

PROMISES:
Book keeping in objects for the location (x and y coordinate) of the balls, cue ball and pool cue/stick.
*/
class Point
{
  float x, y;
  
  Point (float a, float b)
  {
    x = a;
    y = b;
  }
  
  Point ()
  {
    x = 0;
    y = 0;
  }
}

/*The class Ball will be used to manage the location data of the balls (coordinates stored in an object of class Point named center;
center is the center of the cue ball and balls), the contact point of the cue ball, the colors of the balls, and the power 
(velocity and acceleration) of the balls and cue ball in the x and y direction.

REQUIRES:
- A set of three int values inputted in the order "int = R, int = G, int = B" to provide the balls with an RGB color.
- A float value to to provide a radius for the balls.
- A set of two float values to act as x and y values.

PROMISES:
- Book keeping for the power, location, radius, and RGB color values of the cue ball and balls.
*/
class Ball
{
  float rad;
  Point center;
  Point contact_point;
  color col;
  float powerX;
  float powerY;
  
  Ball(float x, float y, float r, int R, int G, int B)
  {
    rad = r;
    center = new Point (x, y);
    contact_point = new Point (mouseX, mouseY);
    col = color(R, G, B);
  }
  
  Ball(float x, float y, float r)
  {
    rad = r;
    center = new Point (x, y);
  }
}

/*The class Stick will be used to manage the location data (coordinates are stored in two objects of class Point named 'start_p', and 'end_p')
of the starting point, ending point of the cue stick, and RGB color of the cue stick (stored in 'col', an object of type color).

REQUIRES: 
- A set of two floats to act as coordinates for the starting point of the pool cue.
- User interaction in the form of moving the mouse. The location of the mouse will act as coordinates for the end point of the pool cue.

PROMISES:
- Book keeping for the location data of the starting, ending point, and RGB color values of the pool cue.
*/
class Stick
{
  Point start_p;
  Point end_p;
  color col; 
  
  
  Stick(float x, float y, int R, int G, int B)
  {
    start_p = new Point (x, y);
    end_p = new Point (mouseX, mouseY);
    col = color(R, G, B);
  }
}

/*The class Table will contain all data for the table, all the balls and the cue in the game. Every ball's book keeping data is 
stored inside the various objects of various classes inside class Table. The specifications of the table are also stored in class
Table.

REQUIRES:
- Class Ball and Class Stick to book keep the data for all the balls and the cue in the game.
- Coordinates and data stored as integers for the table data.

PROMISES:
- Book keeping all relevant data for all the balls, cue ball, stick, and table.
*/
class Table
{
  Ball [] b_arr = new Ball [6];
  Ball cue_ball = new Ball(200, 400, rad, 255, 255, 255);
  Stick st;
  
  int tableLocation = 400;
  int playingL = 600;
  int playingW = 300;
  int tableEdges = 20;
  int holeRad = 50;
  int holeUpperLocation = 250;
  int holeLowerLocation = 550;
  int holeLeftLocation = 100;
  int holeRightLocation = 700;
  
  float [] b_arrLocationX = {575, 600, 600, 625, 625, 625};
  float [] b_arrLocationY = {400, 412.5, 387.5, 425, 400, 375};
  int [][] b_arrCol = {{204, 0, 0}, {204, 204, 0}, {0, 204, 0}, {102, 51, 0}, {0, 128, 255}, {0, 0, 0}};
}

/*Class 'CueBallMovement' manages the movement of the cue ball only and applies friction to the cue ball. It contains
the function 'acceleration' which acts as a physics engine for the cue ball. The 'CueBallMovement' class calculates
the acceleration of the cue ball in the X and Y direction based on the distance between the location of the cue ball and the mouse 
cursor. The greater the distance, the greater the acceleration. The acceleration is then multiplied by the variable of type 
float named 'friction' to provide resistance to the cue ball. The acceleration in the X direction is stored in 'accelerationX',
the acceleration in the Y direction is stored in 'accelerationY' and will both be later called in a different function.

REQUIRES:
- A set of two floats that are the x and y coordinates of the cue ball.
- User interaction in the form of mouse movement. The x and y coordinate of the mouse cursor is stored and used.
- The global float variable friction.

PROMISES:
- To calculate and book keep the acceleration of the cue ball.
- To apply resistance, and eventually stop the cue ball from moving.
*/

class CueBallMovement
 {
  float accelerationX;
  float accelerationY;

  CueBallMovement(float x, float y)
   {
    accelerationX = ((x - mouseX)*friction);
    accelerationY = ((y - mouseY)*friction);
   }  
  
  /*Function acceleration takes the location of the cue ball in the form of two floats. The first float represents the x coordinate,
  and the second float represents the y coordinate. The function 'acceleration' will also take the x and y coordinate of the mouse cursor.
  The function will then calculate the acceleration based off of the distance between the x and y coordinate of the ball, and the x and y
  coordinate of the mouse cursor. It will then multiply the distance by friction to add resistance. The acceleration in the X direction
  will be stored in accelerationX, and the acceleration in the Y direction will be stored in accelerationY.
  */
  void acceleration(float x, float y)
   {
    accelerationX = ((x - mouseX)*friction);
    accelerationY = ((y - mouseY)*friction);
   }
 }