class Block
{
  int x,y;
  Block(int _x, int _y)
  {
    x=_x;
    y=_y;
  }
  boolean black;
  boolean start;
  boolean end;
  void display()
  {
    if (black||start||end) 
    {
      fill(0);
    } else 
    {
      fill(255);
    }
    rect(x, y, width/10, height/10);
    if (black||start||end) 
    {
      fill(255);
    } else 
    {
      fill(0);
    }
    if(end)
    {
      text("END",x+10,y+30);
    }
  }
}