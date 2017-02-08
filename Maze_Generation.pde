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

void setup()
{
  noCursor();
  noStroke();
  //frameRate(60);
  fullScreen();
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
void draw()
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
void reset()
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