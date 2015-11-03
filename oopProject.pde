//Programming assignemnt - new branch
String word = new String();
PImage background;
float topBorder;
float sideBorder;

void setup()
{
  size(1500,1000);
  topBorder = height/10;
  sideBorder = width/15;
  
  background = loadImage("background.jpg");

  PFont font = loadFont("mainFont.vlw");
  textFont(font,width/35);
  
  String[] data = loadStrings("stats.csv");
  ArrayList stats = new ArrayList();
  
  for(int i = 0;i<data.length;i++)
  {
    stats.add(data[i]);
  }
  
}

void draw()
{
  image(background,0,0,width,height);
  text(word,sideBorder,topBorder);
  
}

void keyTyped()
{
  if((key!=8)&&(word.length()<25)&&(key!='\n'))
  {
  word = word + key;
  }
  else if((key==8)&&(word.length()>0))
  {
   word = word.substring(0,word.length()-1);
  }
}
