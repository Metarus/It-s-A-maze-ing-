int generation;
int end;
ArrayList<Block> blocks = new ArrayList<Block>();
boolean genUp=true, genDown=true, genLeft=true, genRight=true;

void setup()
{
  //frameRate(200);
  fullScreen();
  for (int i=0; i<10; i++)
  {
    for (int j=0; j<10; j++)
    {
      blocks.add(new Block((width/10)*j, (height/10)*i));
    }
  }
  int l=(int)random(10);
  switch((int)random(4))
  {
  case 0:
    blocks.get(l).start=true;
    blocks.get(99-l).end=true;
    generation=l;
    end=99-l;
    break;
  case 1:
    blocks.get(l*10).start=true;
    blocks.get(99-(l*10)).end=true;
    generation=l*10;
    end=99-(l*10);
    break;
  case 2:
    blocks.get(l+90).start=true;
    blocks.get(99-(l+90)).end=true;
    generation=l+90;
    end=99-(l+90);
    break;
  case 3:
    blocks.get(l*10+9).start=true;
    blocks.get(99-(l*10+9)).end=true;
    generation=l*10+9;
    end=99-(l*10+9);
    break;
  }
}
void draw()
{  
  if (generation!=end)
  {
    for (int i=0; i<100; i++)
    {
      Block part=blocks.get(i);
      part.display();
      text(i, part.x+10, part.y+20);
    }
    if (generation%10!=9)
    {
      if (blocks.get(generation+1).black)
      {
        genRight=false;
      } else genRight=true;
    } else genRight=false; 

    if (generation%10!=0)
    {
      if (blocks.get(generation-1).black)
      {
        genLeft=false;
      } else genLeft=true;
    } else genLeft=false; 

    if (generation<90)
    {
      if (blocks.get(generation+10).black)
      {
        genDown=false;
      } else genDown=true;
    } else genDown=false;

    if (generation>9)
    {
      if (blocks.get(generation-10).black)
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
        generation+=10;
      }
      break;
    case 3:
      if (genUp)
      {
        generation-=10;
      }
      break;
    }
    blocks.get(generation).black=true;

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