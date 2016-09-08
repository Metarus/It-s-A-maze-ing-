class Player
{
  PVector v1=new PVector(0, 0);

  float x, y;
  void update()
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