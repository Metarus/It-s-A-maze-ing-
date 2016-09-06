class Block
{
  int x, y;
  Block(int _x, int _y)
  {
    x=_x;
    y=_y;
  }
  int identifier;
  boolean white, start, end, segment;
  int topLeft, topRight, bottomLeft, bottomRight;
  void display()
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
      } else topLeft=10;
    } else topLeft=0;

    if (identifier>gridWidth&&identifier%gridWidth!=gridWidth-1)
    {
      if (blocks.get(identifier+1).white||blocks.get(identifier-gridWidth).white)
      {
        topRight=0;
      } else topRight=10;
    } else topRight=0;

    if (identifier<(gridWidth*gridHeight)-gridWidth&&identifier%gridWidth!=0)
    {
      if (blocks.get(identifier-1).white||blocks.get(identifier+gridWidth).white)
      {
        bottomLeft=0;
      } else bottomLeft=10;
    } else bottomLeft=0;

    if (identifier<(gridWidth*gridHeight)-gridWidth&&identifier%gridWidth!=gridWidth-1)
    {
      if (blocks.get(identifier+1).white||blocks.get(identifier+gridWidth).white)
      {
        bottomRight=0;
      } else bottomRight=10;
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
      fill(240);
    }
    rect(x, y, width/gridWidth, height/gridHeight, topLeft, topRight, bottomRight, bottomLeft);
    if (white) 
    {
      fill(0);
    } else 
    {
      fill(255);
    }
    if (end)
    {
      text("END", x+10, y+30);
    }
    if (start)
    {
      text("START", x+10, y+30);
    }
  }
}