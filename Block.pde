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
  void update()
  {
    if (start)
    {
      segment=true;
      white=true;
    }
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
    if(segment)
    {
      fill(245);
    }
    if(start)
    {
      fill(255,0,0);
    }
    if(end)
    {
      fill(0,0,255);
    }
    rect(x, y, width/gridWidth, height/gridHeight, topLeft, topRight, bottomRight, bottomLeft);
    if(player.x>x&&player.x<(x+width/gridWidth)&&player.y>y&&player.y<(y+height/gridHeight)&&white==false)
    {
      died=true;
    }
    if(resetting&&start)
    {
      player.x=x+((width/gridWidth)/2);
      player.y=y+((height/gridHeight)/2);
      fill(255);
      text("DIED",player.x,player.y);
      resetting=false;
    }
  }
}