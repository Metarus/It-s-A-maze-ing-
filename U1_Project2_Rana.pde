int generation;
int end;
int gridWidth=19;
int gridHeight=19;
int start;
ArrayList<Block> blocks = new ArrayList<Block>();
boolean genUp=true, genDown=true, genLeft=true, genRight=true, generating=true;

void setup()
{
  noStroke();
  frameRate(999999);
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

    blocks.get(l*gridWidth).start=true;
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
  start=generation;
}
void draw()
{
  for (int i=0; i<gridWidth*gridHeight; i++)
  {
    Block part=blocks.get(i);
    part.display();
    part.identifier=i;
    //text(i, part.x+10, part.y+20);
  }
  if (generating)
  {
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
    //genTest();

    if (generation==end)
    {
      generating=false;
    }

    if (genUp==false&&genDown==false&&genRight==false&&genLeft==false)
    {
      //reset();
      generating=false;
    }
  } else generating=false;

  if (generating==false)
  {
    println("Done");
  }
  if (mousePressed)
  {
    reset();
  }
  if (generating==false)
  {
    int i=(int)random(gridWidth*gridHeight);
    if (blocks.get(i).segment&&blocks.get(i).end==false)
    {
      generation=i;
      generating=true;
    }
  }
}
void reset()
{
  blocks.clear();
  genUp=true;
  genDown=true;
  genLeft=true;
  genRight=true;
  generating=true;
  setup();
}