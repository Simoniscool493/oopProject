//DT228-2 Programming assignment
//Simon O'Neill C14444108

ArrayList<Species> sp = new ArrayList<Species>();
String word = new String();
PFont font;
PImage background;
String[] rawData;
String[] names;
float topBorder;
float sideBorder;
int highestStat;
int numStats = 6;
int numTerms = 4;
int numEntries = 4;
int maxWordLength = 25;
int textColor = 255;
String[] statNames = {"HP","Atk","Def","SpAtk","SpDef","Speed"};

void setup()
{
  size(1500,1000);
  
  topBorder = height/9;
  sideBorder = width/15;
  
  loadFiles();
  setFont();

  getdata();
  
  for(Species s: sp)
  {
    s.formatName();
    numEntries = s.index;
  }
  
  highestStat = findHighest();
}

void draw()
{
  image(background,0,0,width,height);
  text(word,sideBorder,topBorder);
 
  for(Species s: sp)
  {
    if(parseInt(word)==s.index||(lwr(word)).equals(lwr(s.name)))
    {
      s.drawStatGraph();
      s.printDetails();
    }
  }
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

void getdata()
{
  for(int i=0;i<rawData.length;i+=6)
  {
    Species species = new Species();
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
