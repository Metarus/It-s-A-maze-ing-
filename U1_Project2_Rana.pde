int generation;
int end;
int gridWidth=20;
int gridHeight=20;
ArrayList<Block> blocks = new ArrayList<Block>();
boolean genUp=true, genDown=true, genLeft=true, genRight=true;

void setup()
{
  noStroke();
  //frameRate(200);
  fullScreen();
  background(0);
  for (int i=0; i<gridHeight; i++)
  {
    for (int j=0; j<gridWidth; j++)
    {
      blocks.add(new Block((width/gridWidth)*j, (height/gridHeight)*i));
    }
  }
  int l;
  switch((int)random(4))
  {
  case 0:
    l=(int)random(gridWidth);

    blocks.get(l).start=true;
    blocks.get((gridWidth*gridHeight-1)-l).end=true;
    generation=l;
    end=(gridWidth*gridHeight-1)-l;
    break;
  case 1:
    l=(int)random(gridHeight);

    blocks.get(l*gridHeight).start=true;
    blocks.get((gridWidth*gridHeight-1)-(l*gridHeight)).end=true;
    generation=l*gridHeight;
    end=(gridWidth*gridHeight-1)-(l*gridHeight);
    break;
  case 2:
    l=(int)random(gridWidth);

    blocks.get(l+(gridWidth*(gridHeight-1))).start=true;
    blocks.get((gridWidth*gridHeight-1)-(l+(gridWidth*(gridHeight-1)))).end=true;
    generation=l+(gridWidth*(gridHeight-1));
    end=(gridWidth*gridHeight-1)-(l+(gridWidth*(gridHeight-1)));
    break;
  case 3:
    l=(int)random(gridHeight);

    blocks.get(l*gridWidth+(gridWidth-1)).start=true;
    blocks.get((gridWidth*gridHeight-1)-(l*gridWidth+(gridWidth-1))).end=true;
    generation=l*gridWidth+(gridWidth-1);
    end=(gridWidth*gridHeight-1)-(l*gridWidth+(gridWidth-1));
    break;
  }
}
void draw()
{  
  if (generation!=end)
  {
    for (int i=0; i<gridWidth*gridHeight; i++)
    {
      Block part=blocks.get(i);
      part.display();
      //text(i, part.x+10, part.y+20);
    }
    if (generation%gridWidth!=gridWidth-1)
    {
      if (blocks.get(generation+1).white)
      {
        genRight=false;
      } else genRight=true;
    } else genRight=false; 

    if (generation%gridWidth!=0)
    {
      if (blocks.get(generation-1).white)
      {
        genLeft=false;
      } else genLeft=true;
    } else genLeft=false; 

    if (generation<(gridWidth*gridHeight)-gridWidth)
    {
      if (blocks.get(generation+gridWidth).white)
      {
        genDown=false;
      } else genDown=true;
    } else genDown=false;

    if (generation>gridWidth-1)
    {
      if (blocks.get(generation-gridWidth).white)
      {
        genUp=false;
      } else genUp=true;
    } else genUp=false;

    int randomGen=(int)random(4);
    switch(randomGen)
    {
    case 0:
      if (genRight)
      {
        generation++;
      }
      break;
    case 1:
      if (genLeft)
      {
        generation--;
      }
      break;
    case 2:
      if (genDown)
      {
        generation+=gridWidth;
      }
      break;
    case 3:
      if (genUp)
      {
        generation-=gridWidth;
      }
      break;
    }
    blocks.get(generation).white=true;

    if (genUp==false&&genDown==false&&genRight==false&&genLeft==false)
    {
      reset();
    }
  } else println("It's complete");
  if (mousePressed)
  {
    reset();
  }
}
void reset()
{
  blocks.clear();
  genUp=true;
  genDown=true;
  genLeft=true;
  genRight=true;
  setup();
}