class Block
{
  int x, y;
  Block(int _x, int _y)
  {
    x=_x;
    y=_y;
  }
  boolean white;
  boolean start;
  boolean end;
  void display()
  {
    if (white||start||end) 
    {
      fill(255);
    } else 
    {
      fill(0);
    }
    rect(x, y, width/gridWidth, height/gridHeight, 10);
    if (white||start||end) 
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
  }
}