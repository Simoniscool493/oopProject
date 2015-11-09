//Programming assignemnt
String word = new String();
PImage background;
PFont font;
float topBorder;
float sideBorder;
int numEntries;
int numStats = 6;
int maxWordLength = 25;
String[] rawData;
String[] species;
String[][] stats;
String[] statNames = {"HP","Atk","Def","SpAtk","SpDef","Speed"};


void setup()
{
  size(1500,1000);

  topBorder = height/9;
  sideBorder = width/15;
  
  loadFiles();
  initializeVariables();
  
  textFont(font,width/35);
  
  formatSpecies();
  getdata();
}

void draw()
{
  image(background,0,0,width,height);
  text(word,sideBorder,topBorder);
  
  if(parseInt(word)<numEntries&&parseInt(word)>0)
  {
    drawText();
    drawGraph();
  }
}

void initializeVariables()
{
  numEntries=(rawData.length)/numStats;
  stats = new String[numEntries][numStats];
}

void loadFiles()
{
  rawData = loadStrings("stats.csv");
  species = loadStrings("species.csv");
  background = loadImage("background.jpg");
  font = loadFont("mainFont.vlw");
}

void drawText()
{
  text(species[parseInt(word)-1],sideBorder,topBorder*2);

  for(int i=0;i<numStats;i++)
  {
     text(statNames[i] + " = " + stats[parseInt(word)-1][i],sideBorder,topBorder*(i+3));
  }
}

void drawGraph()
{
  float graphGap = (sideBorder*9)/6;
  float graphHeight = height-topBorder;
  
  line(sideBorder*5,graphHeight,sideBorder*14,graphHeight);
  
  for(int i=0;i<numStats;i++)
  {      
    float stat = parseInt(stats[parseInt(word)-1][i]);
    stat = stat*3.25;
    fill(i*(255/6),0,255-(i*(255/6)));
    
    rect((sideBorder*5)+(graphGap*i),graphHeight-stat,graphGap,stat);
    fill(255);
    //text(statNames[i],sideBorder*5+(graphGap*i),height-topBorder/2);
    text((int)(stat/3.25),sideBorder*5+(graphGap*i)+graphGap/2.75,height-topBorder/2);
  }
  
}

void getdata()
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

void formatSpecies()
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
  if((key!=8)&&(word.length()<maxWordLength)&&(key!='\n')&&(key!= 61)&&(key!= 45))
  {
  word = word + key;
  }
  else if((key==8)&&(word.length()>0))
  {
   word = word.substring(0,word.length()-1);
  }
  if(key == 61||key == 45)
  {
    int buffer = parseInt(word);
    if(key == 61)
    {
    buffer++;
    }
    else
    {
    buffer--;
    }
    word = String.valueOf(buffer);
  } 
}
