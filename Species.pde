class Species
{
  int index;
  String name;
  int stats[] = new int[numStats+1];
  
  Minim minim;
  
  PApplet gif_this;
  java.lang.Object cry_this;
  
  Gif sprite;
  AudioPlayer cry;
  
  Species(PApplet parent,java.lang.Object parent2)
  {
    gif_this = parent;
    cry_this = parent2;
  }
  
  void printDetails()
  {
    fill(textColor);
    text(name,sideBorder,topBorder*2);

    for(int i=0;i<numStats;i++)
    {
      text(statNames[i] + " = " + stats[i],sideBorder,topBorder*(i+3));
    }
  }//end printDetails
  
  void drawStatGraph()
  {
    float graphGap = (sideBorder*9)/6;
    float graphHeight = height-topBorder*2;
   
    line(sideBorder*5,height-topBorder,sideBorder*14,height-topBorder);
    
    for(int i=0;i<numStats;i++)
    {
      fill(statColors[0][i],statColors[1][i],statColors[2][i]);
      float stat = stats[i];
      stat = map(stat,0,highestStat,0,graphHeight);              
      rect((sideBorder*5)+(graphGap*i),height-topBorder-stat,graphGap,stat);
       
      fill(textColor);
      text(statNames[i],sideBorder*5+(graphGap*i),height-topBorder/2);
    }     
  }//end drawStatGraph
  
  void drawHex()
  {
    float thetaInc = TWO_PI/numStats;
    float r = spreadRad;
    float cx = width/2+sideBorder;
    float cy = height/2;
     
    for(int i=0;i<numStats;i++)
    {
      fill(statColors[0][i],statColors[1][i],statColors[2][i]);
      
      float mappedStat1 = map(stats[i],0,highestStat,0,spreadRad);
      float mappedStat2 = map(stats[i+1],0,highestStat,0,spreadRad);
        
      float theta = i*thetaInc;
      float nextTheta = (i+1)*thetaInc;
      float x1 = cx+sin(theta)*r;
      float y1 = cy-cos(theta)*r;
      float x2 = cx+sin(theta)*mappedStat1;
      float y2 = cy-cos(theta)*mappedStat1;
      float x3 = cx+sin(nextTheta)*mappedStat2;
      float y3 = cy-cos(nextTheta)*mappedStat2;
      float textX = cx+sin(theta)*r*1.1;
      float textY = cy-cos(theta)*r*1.1;
        
      line(cx,cy,x1,y1);
      triangle(cx,cy,x2,y2,x3,y3);
      text(statNames[i],textX,textY);
    }
  }//end drawHex
  
  void formatName()
  {
    name = (name.substring(0,name.length()-1));
    char[] buffer = new char[12];
    buffer = name.toCharArray();
    buffer[0] -= 32;
    name = String.valueOf(buffer);
  }//end formatName
  
  int topStat()
  {
    int n = 0;

    for(int i=0;i<numStats;i++)
    {
      if(stats[i]>n)
      {
        n = stats[i];
      }
    }
    
    return n;
  }//end topStat
  
  void loadSprite()
  {
    String path = "sprites/" + getNum() + ".gif";
    sprite = new Gif(gif_this,path);
  }//end loadSprite
  
  void loadCry()
  {
    minim = new Minim(cry_this);
    
    String path = "cries/" + getNum() + ".wav";
    cry = minim.loadFile(path);
  }//end loadCry
     
  void displayGif(float x,float y,float hgt,float wth)
  {
    image(sprite,x,y,(sprite.width)*spriteScale,(sprite.height)*spriteScale);
    sprite.play();    
  }//end displayGif
  
  void playCry()
  {
    cry.rewind();
    cry.play();
  }//end playCry
  
  String getNum()
  {
    String path = String.valueOf(index);
    
    while(path.length()<3)
    {
      path = "0" + path;
    }
    
    return path;
  }//end getNum
}//end class Species
