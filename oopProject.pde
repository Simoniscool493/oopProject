//Programming assignemnt
String word = new String();
PImage background;
float topBorder;
float sideBorder;
int numEntries;
int numStats = 6;
int rawData_length;
String[] rawData = new String[rawData_length];
String[] species = new String[numEntries];

void setup()
{
  size(1500,1000);
  topBorder = height/9;
  sideBorder = width/15;
  
  background = loadImage("background.jpg");
  PFont font = loadFont("mainFont.vlw");
  textFont(font,width/35);
  
  rawData = loadStrings("stats.csv");
  species = loadStrings("species.csv");
  
  rawData_length = rawData.length;
  numEntries=(rawData.length)/numStats;
  formatSpecies(species);
}



void draw()
{
  String[][] stats = new String[numEntries][numStats];
  getdata(rawData,stats);
    

  image(background,0,0,width,height);
  text(word,sideBorder,topBorder);
  
  if(parseInt(word)<numEntries&&parseInt(word)>0)
  {
        text(species[parseInt(word)-1],sideBorder,topBorder*2);
        text("HP = " + stats[parseInt(word)-1][0],sideBorder,topBorder*3);
        text("Atk = " + stats[parseInt(word)-1][1],sideBorder,topBorder*4);
        text("Def = " + stats[parseInt(word)-1][2],sideBorder,topBorder*5);
        text("SpAtk = " + stats[parseInt(word)-1][3],sideBorder,topBorder*6);
        text("SpDef = " + stats[parseInt(word)-1][4],sideBorder,topBorder*7);
        text("Speed = " + stats[parseInt(word)-1][5],sideBorder,topBorder*8);
        
        draw
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

void formatSpecies(String[] species)
{
  for(int i=0;i<species.length-1;i++)
  {
    species[i] = (species[i].substring(0,species[i].length()-1));
    char[] buffer = new char[12];
    buffer = species[i].toCharArray();
    buffer[0] -= 32;
    species[i] = String.valueOf(buffer);
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


