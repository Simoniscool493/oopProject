//Programming assignemnt
String word = new String();
PImage background;
float topBorder;
float sideBorder;
int numEntries;
int numStats = 6;

void setup()
{
  size(1500,1000);
  topBorder = height/10;
  sideBorder = width/15;
  background = loadImage("background.jpg");
  PFont font = loadFont("mainFont.vlw");
  textFont(font,width/35);
  
  
  String[] rawData = loadStrings("stats.csv");
  numEntries=(rawData.length)/numStats;
  String[][] stats = new String[numEntries][numStats];
  
  
  getdata(rawData,stats);
  
  
  println(stats[383][0]);
 
}

void draw()
{
  image(background,0,0,width,height);
  text(word,sideBorder,topBorder);
  
  for(int i=0;i<numEntries;i++)
  {
    if(parseInt(word)!=stats[0][0])
    {
     println(parseInt(word));
    }
  }
  
  
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

void getdata(String[] rawData,String[][] stats)
{
  int spec = 0;
  
  for(int i=0;i<rawData.length-1;i++)
  {
      String[] buffer = split(rawData[i],',');
      stats[spec][Integer.parseInt(buffer[1])-1] = buffer[2];
      
      if(Integer.parseInt(buffer[1])==numStats)
      {
        spec++;
      }
  }
  
}
