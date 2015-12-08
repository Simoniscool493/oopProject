class Species
{
  int index;
  String name;
  int stats[] = new int[numStats+1];
  //main species variables
  
  Minim minim;
  //minin for audio player
  
  PApplet gif_this;
  //PApplet for gif
  java.lang.Object cry_this;
  //java.lang.Object for audio player
  
  Gif sprite;
  AudioPlayer cry;
  //actual gif and audio player
  
  Species(PApplet parent,java.lang.Object parent2)
  //constructor that defines the passed 'this' variables for use in the media players
  {
    gif_this = parent;
    cry_this = parent2;
  }
  
  void printDetails()
  //prints basic details about the species
  {
    fill(textColor);
    text(name,sideBorder,topBorder*2);

    for(int i=0;i<numStats;i++)
    {
      text(statNames[i] + " = " + stats[i],sideBorder,topBorder*(i+3));
    }
  }//end printDetails
  
  void drawStatGraph()
  //draws a bar chart of the species' stats
  {
    stroke(0);
       
    for(int i=0;i<numStats;i++)
    {
      fill(statColors[0][i],statColors[1][i],statColors[2][i]);
      //stat color is decided based on previously defined array of colors
      
      float stat = stats[i];
      stat = map(stat,0,highestStat,0,smallGraphHeight); 
      //stat is mapped to graph height
      
      rect((sideBorder*5)+(smallGraphGap*i),height-topBorder-stat,smallGraphGap,stat);
      //bar is drawn
       
      fill(textColor);
      text(statNames[i],sideBorder*5+(smallGraphGap*i),height-topBorder/2);
      //bar is labeled
    }     
  }//end drawStatGraph
  
  void drawHex()
  //draws a hexagonal spread graph of stats
  {
    stroke(0);
     
    for(int i=0;i<numStats;i++)
    {
      fill(statColors[0][i],statColors[1][i],statColors[2][i]);
      
      float mappedStat1 = map(stats[i],0,highestStat,0,spreadRad);
      float mappedStat2 = map(stats[i+1],0,highestStat,0,spreadRad);
      //maps the stats to the radius of the spread graph
        
      float theta = i*thetaInc;
      float nextTheta = (i+1)*thetaInc;
      //sets the two angles of the outer points of the triangle to be drawn for the spread graph.
      //the spread graph is a set of triangles rotated around a central point.
      
      float x1 = cx+sin(theta)*spreadRad;
      float y1 = cy-cos(theta)*spreadRad;
      //sets the outermost point on the current angle of the graph
      
      float x2 = cx+sin(theta)*mappedStat1;
      float y2 = cy-cos(theta)*mappedStat1;
      float x3 = cx+sin(nextTheta)*mappedStat2;
      float y3 = cy-cos(nextTheta)*mappedStat2;
      //sets the positions of the two points of the triangle that change every iteration
      //these points are the two that rotate every iteration
      
      float textX = cx+sin(theta)*spreadRad*1.1;
      float textY = cy-cos(theta)*spreadRad*1.1;
      //sets the point that the stat label will be drawn at. these also rotate
        
      line(cx,cy,x1,y1);
      triangle(cx,cy,x2,y2,x3,y3);
      text(statNames[i],textX,textY);
    }
  }//end drawHex
  
  void formatName()
  //capitalizes the first letter of the species name, and removes the comma at the end
  {
    name = (name.substring(0,name.length()-1));
    char[] buffer = new char[12];
    buffer = name.toCharArray();
    buffer[0] -= 32;
    name = String.valueOf(buffer);
  }//end formatName
  
  int topStat()
  //simple method that returns the species' highest stat
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
   
  void printBasics()
  //prints some basic details about the species
  {
    fill(255,map(totalStats(),lowestTotal,highestTotal,0,255),0);
    text("Stat total: "+totalStats(),sideBorder*5,topBorder);
            
    printDetails();
    displayGif(width-sideBorder*2,topBorder*1.5,200,200);
    
  }//end printBasics
  
  int totalStats()
  //simple method that returns the base stat total of the species
  {
    int ans = 0;
    
    for(int i=0;i<numStats;i++)
    {
      ans+=stats[i];
    }
    
    return ans;
  }
  
  void loadSprite()
  //simple method that loads the species' sprite from the data folder
  {
    String path = "sprites/" + getNum() + ".gif";
    sprite = new Gif(gif_this,path);
  }//end loadSprite
  
  void loadCry()
  //simple method that loads the species' cry from the data folder
  {
    minim = new Minim(cry_this);
    
    String path = "cries/" + getNum() + ".wav";
    cry = minim.loadFile(path);
  }//end loadCry
     
  void displayGif(float x,float y,float hgt,float wth)
  //method that displays the species' sprite
  {
    image(sprite,x,y,(sprite.width)*spriteScale,(sprite.height)*spriteScale);
    sprite.play();    
  }//end displayGif
  
  void playCry()
  //method that plays the species' cry
  {
    cry.rewind();
    cry.play();
  }//end playCry
  
  String getNum()
  //method that reurns the species' index number in dex format. used to load its cry and sprite.
  {
    String path = String.valueOf(index);
    
    while(path.length()<3)
    {
      path = "0" + path;
    }
    
    return path;
  }//end getNum
}//end class Species
