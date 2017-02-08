import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Maze_Generation extends PApplet {

/*
Maze generation with player movement code turned into a basic game.
Maze game
*/

int generation;
int end;
int gridWidth=9;
int gridHeight=9;
int start;
int cellWidth;
int cellHeight;
ArrayList<Block> blocks = new ArrayList<Block>();
boolean genUp=true, genDown=true, genLeft=true, genRight=true, generating=true, resetting, go, genEnd;

Player player=new Player();

public void setup()
{
  noCursor();
  noStroke();
  //frameRate(60);
  
  background(0);
  //Sets the cellWidth and cellHeight which are very important
  cellWidth=width/gridWidth;
  cellHeight=height/gridHeight;
  for (int i=0; i<gridHeight; i++)
  {
    for (int j=0; j<gridWidth; j++)
    {
      blocks.add(new Block((width/gridWidth)*j, (height/gridHeight)*i));
    }
  }
  //Selecting a random start and finish based on opposites
  int l;
  switch((int)random(4))
  {
  case 0:
    l=(int)random(gridWidth);
    if (l%2==1)
    {
      l++;
    }
    blocks.get(l).start=true;
    blocks.get((gridWidth*gridHeight-1)-l).end=true;
    generation=l;
    end=(gridWidth*gridHeight-1)-l;
    break;
  case 1:
    l=(int)random(gridHeight);
    if (l%2==1)
    {
      l++;
    }
    blocks.get(l*gridWidth).start=true;
    blocks.get((gridWidth*gridHeight-1)-(l*gridHeight)).end=true;
    generation=l*gridHeight;
    end=(gridWidth*gridHeight-1)-(l*gridHeight);
    break;
  case 2:
    l=(int)random(gridWidth);
    if (l%2==1)
    {
      l++;
    }
    blocks.get(l+(gridWidth*(gridHeight-1))).start=true;
    blocks.get((gridWidth*gridHeight-1)-(l+(gridWidth*(gridHeight-1)))).end=true;
    generation=l+(gridWidth*(gridHeight-1));
    end=(gridWidth*gridHeight-1)-(l+(gridWidth*(gridHeight-1)));
    break;
  case 3:
    l=(int)random(gridHeight);
    if (l%2==1)
    {
      l++;
    }
    blocks.get(l*gridWidth+(gridWidth-1)).start=true;
    blocks.get((gridWidth*gridHeight-1)-(l*gridWidth+(gridWidth-1))).end=true;
    generation=l*gridWidth+(gridWidth-1);
    end=(gridWidth*gridHeight-1)-(l*gridWidth+(gridWidth-1));
    break;
  }
  start=generation;
}
public void draw()
{
  background(0);
  for (int i=0; i<gridWidth*gridHeight; i++)
  {
    //Updating the blocks
    Block part=blocks.get(i);
    part.update();
    part.identifier=i;
    if (part.died)
    {
      part.died=false;
      resetting=true;
    }
  }
  if (generating&&genEnd==false) //Generation code (Before mousePressed)
  {
    //genLeft,Right,Up,Down are all variables which say if it can generate in those directions
    if (generation%gridWidth<gridWidth-2)
    {
      if (blocks.get(generation+2).white)
      {
        genRight=false;
      } else genRight=true;
    } else genRight=false; 

    if (generation%gridWidth>1)
    {
      if (blocks.get(generation-2).white)
      {
        genLeft=false;
      } else genLeft=true;
    } else genLeft=false; 

    if (generation<(gridWidth*gridHeight)-(2*gridWidth))
    {
      if (blocks.get(generation+(2*gridWidth)).white)
      {
        genDown=false;
      } else genDown=true;
    } else genDown=false;

    if (generation>2*gridWidth-1)
    {
      if (blocks.get(generation-(2*gridWidth)).white)
      {
        genUp=false;
      } else genUp=true;
    } else genUp=false;

    //Choosing a random direction to generate in
    int randomGen=(int)random(4);
    switch(randomGen)
    {
    case 0:
      if (genRight)
      {
        generation++;
        blocks.get(generation).white=true;
        generation++;
        blocks.get(generation).white=true;
        blocks.get(generation).segment=true;
      }
      break;
    case 1:
      if (genLeft)
      {
        generation--;
        blocks.get(generation).white=true;
        generation--;
        blocks.get(generation).white=true;
        blocks.get(generation).segment=true;
      }
      break;
    case 2:
      if (genDown)
      {
        generation+=gridWidth;
        blocks.get(generation).white=true;
        generation+=gridWidth;
        blocks.get(generation).white=true;
        blocks.get(generation).segment=true;
      }
      break;
    case 3:
      if (genUp)
      {
        generation-=gridWidth;
        blocks.get(generation).white=true;
        generation-=gridWidth;
        blocks.get(generation).white=true;
        blocks.get(generation).segment=true;
      }
      break;
    }
    
    //Makes it so that if it touches the end it stops and doesn't make multiple paths
    if (generation==end)
    {
      generating=false;
    }
    //If it's stuck and can't go anywhere then start somewhere else
    if (genUp==false&&genDown==false&&genRight==false&&genLeft==false)
    {
      generating=false;
    }
  } else generating=false;
  
  //Generate a new maze if a key is pressed
  if (keyPressed)
  {
    reset();
    go=false;
    genEnd=false;
  }
  
  //Make the character start moving and whatnot
  if (mousePressed)
  {
    go=true;
    genEnd=true;
    resetting=true;
  }
  if (generating==false)
  {
    //Randomly select a block to begin generating from
    int i=(int)random(gridWidth*gridHeight);
    //checks that it's a midpoint
    if (blocks.get(i).segment&&blocks.get(i).end==false)
    {
      generation=i;
      generating=true;
    }
  }
  if (go)
  {
    //Updates the player
    player.update();
  }
  fill(0, 0, 255);  
  //The cursor
  ellipse(mouseX, mouseY, 10, 10);
}
public void reset()
{
  //Clearing the blocks and running setup
  blocks.clear();
  genUp=true;
  genDown=true;
  genLeft=true;
  genRight=true;
  generating=true;
  setup();
}
class Block
{
  int x, y;
  boolean died;
  Block(int _x, int _y)
  {
    x=_x;
    y=_y;
  }
  int identifier;
  boolean white, start, end, segment;
  int topLeft, topRight, bottomLeft, bottomRight;
  public void update()
  {
    //Displaying
    if (start)
    {
      segment=true;
      white=true;
    }
    //Doing the curviture
    if (identifier>gridWidth&&identifier%gridWidth!=0)
    {
      if (blocks.get(identifier-1).white||blocks.get(identifier-gridWidth).white)
      {
        topLeft=0;
      } else topLeft=30;
    } else topLeft=0;

    if (identifier>gridWidth&&identifier%gridWidth!=gridWidth-1)
    {
      if (blocks.get(identifier+1).white||blocks.get(identifier-gridWidth).white)
      {
        topRight=0;
      } else topRight=30;
    } else topRight=0;

    if (identifier<(gridWidth*gridHeight)-gridWidth&&identifier%gridWidth!=0)
    {
      if (blocks.get(identifier-1).white||blocks.get(identifier+gridWidth).white)
      {
        bottomLeft=0;
      } else bottomLeft=30;
    } else bottomLeft=0;

    if (identifier<(gridWidth*gridHeight)-gridWidth&&identifier%gridWidth!=gridWidth-1)
    {
      if (blocks.get(identifier+1).white||blocks.get(identifier+gridWidth).white)
      {
        bottomRight=0;
      } else bottomRight=30;
    } else bottomRight=0;

    if (white) 
    {
      fill(255);
    } else 
    {
      fill(0);
    }
    if (segment)
    {
      fill(245);
    }
    if (start)
    {
      fill(255, 0, 0);
    }
    if (end)
    {
      fill(0, 0, 255);
    }
    rect(x, y, width/gridWidth, height/gridHeight, topLeft, topRight, bottomRight, bottomLeft);
    //Testing if the player is on the block and the block is black (so the player is dead
    if (player.x>x&&player.x<(x+width/gridWidth)&&player.y>y&&player.y<(y+height/gridHeight)&&white==false)
    {
      died=true;
    }
    if (resetting&&start)
    {
      player.x=x+((width/gridWidth)/2);
      player.y=y+((height/gridHeight)/2);
      fill(255);
      text("DIED", player.x, player.y);
      resetting=false;
    }
    //Testing for the end
    if (player.x>x&&player.x<(x+width/gridWidth)&&player.y>y&&player.y<(y+height/gridHeight)&&end)
    {
      gridWidth+=2;
      gridHeight+=2;
      died=true;
      reset();
      go=false;
      genEnd=false;
    }
  }
}
class Player
{
  PVector v1=new PVector(0, 0);

  float x, y;
  //Movement code and updating
  public void update()
  {
    stroke(127);
    fill(127);
    v1.x=mouseX-(width/2);
    v1.y=mouseY-(3*(height/4));
    v1.normalize();
    line(width/2, 3*(height/4), mouseX, mouseY);
    ellipse(width/2, 3*(height/4), 20, 20);
    x+=2*v1.x;
    y+=2*v1.y;
    fill(255, 0, 255);
    ellipse(x, y, 10, 10);
    fill(0);
    if (x<0||y<0||x>cellWidth*gridWidth||y>cellHeight*gridHeight)
    {
      resetting=true;
    }
    noStroke();
  }
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Maze_Generation" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
