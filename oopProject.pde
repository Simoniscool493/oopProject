//DT228-2 Programming assignment
//Simon O'Neill C14444108

import gifAnimation.*;
import ddf.minim.*;

ArrayList<Species> sp = new ArrayList<Species>();
String word = new String();

PFont font;
PImage background;

String[] rawData;
String[] names;
String[] statNames = {"HP","Atk","Def","SpAtk","SpDef","Speed"};

float topBorder;
float sideBorder;
float spreadRad;
float spriteScale;

int highestStat;
int numStats = 6;
int numEntries = 4;
int maxWordLength = 25;
int textColor = 255;
int[][] statColors;

char mode = ' ';
char[] modes = {' ','b','s'};

void setup()
{
  size(1500,1000);
  
  topBorder = height/9;
  sideBorder = width/15;
  spreadRad = height/3;
  spriteScale = height/500;
  
  setStatColors();
  loadFiles();
  setFont();

  getData(this,this);
  loadMedia();
  
  highestStat = findHighest();
}

void draw()
{
  changeMode();

  imageMode(CORNER);
  image(background,0,0,width,height);
  
  if(mode == 'b'||mode=='s')
  { 
    text(word,sideBorder,topBorder);
    
    imageMode(CENTER);
    
    for(Species s: sp)
    {
      if(parseInt(word)==s.index||(lwr(word)).equals(lwr(s.name)))
      {
        if(mode == 'b')
        {
          s.drawStatGraph();
        }
        else if(mode == 's')
        {
          s.drawHex();
        }
        
        s.printDetails();
        s.displayGif(width-sideBorder*2,topBorder*1.5,200,200);
        
        if(keyPressed&&key==',')
        {
          s.playCry();
        }
      }
    }
  }
  else if(mode == ' ')
  {
    text("Welcome to the project!\nPress b to open the bar chart menu.\nPress s to open the spread graph\nPress d to open the search menu",sideBorder,topBorder);
  }   
}//end draw

void loadMedia()
{
  println("Loading sprites...");
  
  for(Species s: sp)
  {
    s.formatName();
    s.loadSprite();
   
    numEntries = s.index;
  }
  
  println("Sprites loaded");
  println("Loading cries...");
  
  for(Species s: sp)
  {
    s.loadCry();
  }
  
  println("Cries loaded");
}//end loadMedia

int findHighest()
{
  int ans = 0;
  
  for(Species s: sp)
  {
    int n = s.topStat();
    
    if(n>ans)
    {
      ans = n;
    }
  }
  
  return ans;
}//end findHighest

void setStatColors()
{
  statColors = new int[3][numStats];
  
  for(int i=0;i<numStats;i++)
  {
    statColors[0][i] = i*(255/6);
    statColors[1][i] = 0;
    statColors[2][i] = 255-(i*(255/6));
  }
}//end setStatColors

void changeMode()
{
  if(keyPressed && (key == 32||mode==' '))
  {
    for(int i=0;i<modes.length;i++)
    {
      if(modes[i] == key)
      {   
        word="";
        mode = key;
      }
    }
  } 
}//end changeMode

void loadFiles()
{
  rawData = loadStrings("stats.csv");
  names = loadStrings("species.csv");
  background = loadImage("background.jpg");
  font = loadFont("mainFont.vlw");
}//end loadFiles

void setFont()
{
  if(height<width)
  {
    textFont(font,height/23);
  }
  else
  {
    textFont(font,width/35);
  }
}//end setFont

void getData(PApplet papp,java.lang.Object job)
{
  for(int i=0;i<rawData.length;i+=6)
  {
    Species species = new Species(papp,job);
    sp.add(species);
   
    String[][] buffer = new String[numEntries][numStats];
    
    for(int j=0;j<numStats;j++)
    {
      String[] buffer2 = split(rawData[i+j],',');
        
      for(int k=0;k<numEntries;k++)
      {
        buffer[k][j] = buffer2[k];
      }
      
      species.stats[j] = parseInt(buffer[2][j]);
      species.index = parseInt(buffer2[0]);
      species.name = names[species.index-1];
      species.stats[numStats] = species.stats[0];
    }
  }
}//end getData

void keyTyped()
{
  if((key!=8)&&(word.length()<maxWordLength)&&(key!='\n')&&(key!= 61)&&(key!= 45)&&(key!= ','))
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
}//end keyTyped

String lwr(String st)
{
  char[] buffer = new char[12];
  String ans = new String();
  buffer = st.toCharArray();
    
  for(int i=0;i<buffer.length;i++)
  {
    if(buffer[i]>64&&buffer[i]<91)
    {
      buffer[i] += 32;
    }
  }
    
  ans = String.valueOf(buffer);
  return ans;
}//end lwr
