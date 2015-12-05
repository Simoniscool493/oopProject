//DT228-2 Programming assignment
//Simon O'Neill C14444108

import gifAnimation.*;

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
  
  frameRate(30);  
  size(1500,1000);
  
  topBorder = height/9;
  sideBorder = width/15;
  spreadRad = height/3;
  
  setStatColors();
  loadFiles();
  setFont();

  getdata(this);
  loadSprites();
  
  highestStat = findHighest();
}

void draw()
{
   changeMode();

   imageMode(CORNER);
   image(background,0,0,width,height);
   
    if(mode == 'b'||mode=='s')
    { 
      fill(textColor);
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
        }
      }
    }
    else if(mode == ' ')
    {
      text("Welcome to the project!\nPress b to open the bar chart menu.\nPress s to open the spread graph\nPress d to open the search menu",sideBorder,topBorder);
    }
    
}

void loadSprites()
{
  println("Loading sprites...");
  
  for(Species s: sp)
  {
    s.formatName();
    s.loadSprite();
   
    numEntries = s.index;
  }
  
  println("Sprites loaded");

}
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
}

void setStatColors()
{
  statColors = new int[3][numStats];
  
  for(int i=0;i<numStats;i++)
  {
    statColors[0][i] = i*(255/6);
    statColors[1][i] = 0;
    statColors[2][i] = 255-(i*(255/6));
  }
}

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
}


void loadFiles()
{
  rawData = loadStrings("stats.csv");
  names = loadStrings("species.csv");
  background = loadImage("background.jpg");
  font = loadFont("mainFont.vlw");
}

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
}

void getdata(PApplet papp)
{
  for(int i=0;i<rawData.length;i+=6)
  {
    Species species = new Species(papp);
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
}
