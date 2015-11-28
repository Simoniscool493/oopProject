class Species
{
  int index;
  String name;
  int stats[] = new int[numStats];
  
  void Species()
  {
    
  }
  
  void printDetails()
  {
    fill(textColor);
    text(name,sideBorder,topBorder*2);

    for(int i=0;i<numStats;i++)
    {
       text(statNames[i] + " = " + stats[i],sideBorder,topBorder*(i+3));
    }
  }
  
  void drawStatGraph()
  {
    float graphGap = (sideBorder*9)/6;
    float graphHeight = height-topBorder*2;
   
    line(sideBorder*5,height-topBorder,sideBorder*14,height-topBorder);
    
    for(int i=0;i<numStats;i++)
    {
       fill(i*(255/6),0,255-(i*(255/6)));
       float stat = stats[i];
       stat = map(stat,0,highestStat,0,graphHeight);              
       rect((sideBorder*5)+(graphGap*i),height-topBorder-stat,graphGap,stat);
       
       fill(textColor);
       text(statNames[i],sideBorder*5+(graphGap*i),height-topBorder/2);

    }     
  }
  
  void formatName()
  {
    name = (name.substring(0,name.length()-1));
    char[] buffer = new char[12];
    buffer = name.toCharArray();
    buffer[0] -= 32;
    name = String.valueOf(buffer);
  }
  
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
  }
}
