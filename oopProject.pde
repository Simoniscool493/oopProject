//DT228-2 Programming assignment
//Simon O'Neill C14444108

import gifAnimation.*;
import ddf.minim.*;
//Importing libraries for later use when playing sound and gifs

ArrayList<Species> sp = new ArrayList<Species>();
//Arraylist storing all instances of the species class
String word = new String();
//String storing the search term

PFont font;
PImage background;
//Storing the curent font and background

String[] rawData;
String[] names;
//rawData stores the raw stat data, names stores the raw data for species name.
String[] statNames = {"HP","Atk","Def","SpAtk","SpDef","Speed"};

float topBorder;
float sideBorder;
//screen borders for the different visualistions 

float spreadRad; 
//radius for the spread graph
float spriteScale;
//decides the size of the sprite images
float largeGraphGap;
//gap size for the large graph
float smallGraphGap;
//gap size for the small graph
float smallGraphHeight;
//height for the small graph
float cx;
float cy;
//centre coordinates for the spread graph
float thetaInc;
//theta increment for the spread graph

int highestStat;
//variable to store the highest stat recorded, for capping the size of the bar charts
int lowestTotal;
int highestTotal;
//variables storing the lowest and highest total stats
int numStats = 6;
//variable storing the number of existing stats.
int numEntries = 4;
//variable storing the number of variables in each line of rawData.
int maxWordLength = 25;
//variable storing the maximum allowed word length
int textColor = 255;
//sets the default text color
int[][] statColors;
//creates an array for storing the colors of the different stats

char mode = ' ';
//sets the menu as the default display mode
char[] modes = {' ','b','s','a'};
//declares the valid display modes

void setup()
{
  size(1700,1200);
  
  topBorder = height/9;
  sideBorder = width/15;
  spreadRad = height/3;
  spriteScale = height/500;
  smallGraphGap = (sideBorder*9)/numStats;
  smallGraphHeight = height-topBorder*2;
  cx = width/2+sideBorder;
  cy = height/2;
  thetaInc = TWO_PI/numStats;
  //sets the scale of the images to be drawn, in terms of the height and width

  setStatColors();
  
  loadFiles();
  //loads the raw data, the font, and the background image
  setFont();

  getData(this,this);
  //loads the data into the classes, passing in two 'this' variables from setup. one of them 
  //represents a PApplet for the gif animation, and the other is a java.lang.Object for minim,
  //which plays sound
  
  largeGraphGap = (width-(sideBorder*2))/(rawData.length/numStats);
  //sets the scale of the gap between bars in the larger graph
    
  loadMedia();
  //loads sprites and sounds into their respective places in the species class
  
  highestStat = findHighest();
  //finds the highest stat in the arraylist of species, for mapping to the stat graph
  lowestTotal = findLowestTotal();
  highestTotal = findHighestTotal();
  //finds the highest and lowest base stat totals, for mapping to the large graph
}

void draw()
{
  changeMode();
  //checks if a key is pressed to change the display mode, and changes it if so

  imageMode(CORNER);
  image(background,0,0,width,height);
  
  if(mode == 'b'||mode=='s')
  { 
    text(word,sideBorder,topBorder);
    //displays the search term or index number if in individual search mode
    
    imageMode(CENTER);
    //sets imagemode to center to properly centre the sprite for the species
    
    for(Species s: sp)
    {
      if(parseInt(word)==s.index||(lwr(word)).equals(lwr(s.name)))
      //checks each species index and name for a match with the search term, and displays it if so.
      {
        if(mode == 'b')
        {
          s.drawStatGraph();
        }
        else if(mode == 's')
        {
          s.drawHex();
        }
        //displays one of two visualuisations depending on the current mode
        
        s.printBasics();
        //shows basic data about a species that is common to both visualisations

        if(keyPressed&&key==',')
        {
          s.playCry();
          //plays the species cry if ',' is pressed
        }
      }
    }
  }
  if(mode == 'a')
  {
    drawFullGraph();
    //draws the larger graph if in the relevant mode
  }
  else if(mode == ' ')
  {
    //prints the menu data if in menu mode
    fill(textColor);
    text("Welcome to the project!\nPress 'b' to open the bar chart menu.\nPress 's' to open the spread graph\nPress 'a' to graph all species\n\n",sideBorder,topBorder);
    text("When viewing the graph of a single species, press '+' and '-'\nto cycle through species and press ',' to play the Pokémon cry",sideBorder,topBorder*4);
    text("At any time, press the space bar to return to this menu. Enjoy!",sideBorder,topBorder*6);

  }   
}//end draw

void loadMedia()
{
  println("Loading media...");
  
  for(Species s: sp)
  {
    s.formatName();
    s.loadSprite();
    s.loadCry();
    //for every species, format the name properly and load its sprite into a PImage and its cry into an AudioPlayer
  }
  
  println("Media loaded");
}//end loadMedia

int findHighest()
//simple method to find the highest stat of any species
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

int findLowestTotal()
//simple method to find the species with the lowest base stat total
{
  int ans = 1000;
  
  for(Species s: sp)
  {
    int n = s.totalStats();
    
    if(n<ans)
    {
      ans = n;
    }
  }
  
  return ans;
}//end findHighest

int findHighestTotal()
//simple method to find the species with the highest base stat total
{
  int ans = 0;
  
  for(Species s: sp)
  {
    int n = s.totalStats();
    
    if(n>ans)
    {
      ans = n;
    }
  }
  
  return ans;
}//end findHighest

void setStatColors()
//method that sets the fill color of the stats. Set to a gradient from red to blue
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
//method to check if a pressed key is a valid mode, and to switch to that mode if currently in the menu
{
  if(keyPressed && (key == 32||mode==' '))
  {
    for(int i=0;i<modes.length;i++)
    {
      if(modes[i] == key)
      {
        word="1";
        //sets the default species shown when switched to a new mode to be species #1
        mode = key;
      }
    }
  } 
}//end changeMode

void loadFiles()
//simple method to load files from the data folder into their respective variables
{
  rawData = loadStrings("stats.csv");
  names = loadStrings("species.csv");
  background = loadImage("background.jpg");
  font = loadFont("mainFont.vlw");
}//end loadFiles

void setFont()
//sets the font based on the size of the window
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
//gets the data stored in the raw data strings and puts them in the classes
{
  for(int i=0;i<rawData.length;i+=numStats)
  //for loop runs once for every set of lines - there is one line for every stat of a species
  {
    Species species = new Species(papp,job);
    //passes the two instances of 'this' into the class to be the audioplayer and gif
    sp.add(species);
   
    String[][] buffer = new String[numEntries][numStats];
    //buffer is a 2d array of strings that is used to take in the 6 lines of species stat information.
    //there is one buffer for every [numStats] amount of variables (usually 6)
    
    for(int j=0;j<numStats;j++)
    {
      String[] buffer2 = split(rawData[i+j],',');
      //buffer2 splits the data from its raw form into a set of (usually 4) variables. there is
      //one buffer2 per line
        
      for(int k=0;k<numEntries;k++)
      {
        buffer[k][j] = buffer2[k];
        //puts the 4 variables per line, split by buffer2, into one line of buffer. does this 6 times
        //to fill all 6 lines of each instance of buffer
      }
      
      species.stats[j] = parseInt(buffer[2][j]);
      species.index = parseInt(buffer2[0]);
      //puts the stat data into the class from buffer
      
      species.name = names[species.index-1];
      //puts the species name data into the class from the raw names[] array. these names will be formated later
      
      species.stats[numStats] = species.stats[0];
      //adds an exra stat after all natural stats, equal to the first stat. this is for when the spread graph
      //finishes drawing, and needs to fetch an extra stat from the array to finish drawing itself 
    }
  }
}//end getData

void keyTyped()
//keyTyped in this program is used to enter a term to search for in the individual species visualisations.
{
  if((key!=8)&&(word.length()<maxWordLength)&&(key!='\n')&&(key!= 61)&&(key!= 45)&&(key!= ','))
  //adds a character to the search term. does not allow the newline character, the +/- keys (which
  //are used for incrementing the ID numbers) and the comma key, which plays the cry.
  {
    word = word + key;
  }
  else if((key==8)&&(word.length()>0))
  //takes one from the search term if backspace is pressed
  {
    word = word.substring(0,word.length()-1);
  }
  if(key == 61||key == 45)
  //cycles up or down the list of species indexes when + and - are pressed.
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
//simple method for making a string lowercase.
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

void drawFullGraph()
//method that draws the graph showing the base stat total for all species.
{
  stroke(255);
  float lineHeight =0;
  float offset=0;
  //offset tracks how far to the side each bar is to be drawn.
  line(sideBorder,height-topBorder,width-sideBorder,height-topBorder);
  //drawing the x-axis
  line(sideBorder,height-topBorder,sideBorder,topBorder);
  //drawing the y-axis
  
  for(Species s:sp)
  //draws the bar for each species
  {
    float mappedTotal = map(s.totalStats(),lowestTotal,highestTotal,0,height-topBorder*2);
    //maps the base stat total for the species to the height of the graph
    fill(255,map(s.totalStats(),lowestTotal,highestTotal,0,255),0);
    //sets the color of the bar to represent how strong the species is
    
    if(mouseX>sideBorder+offset && mouseX<sideBorder+offset+largeGraphGap)
    //prints some details on the species if the mouse is hovered over its bar
    {
      text(s.index+"\n"+s.name+"\nBase stat total: "+s.totalStats(),sideBorder*2,topBorder);
      lineHeight = mappedTotal;
      fill(255);
    }
    
    stroke(255);
    rect(sideBorder+offset,height-(topBorder+mappedTotal),largeGraphGap,mappedTotal);
    //draws the bar for the species
    offset+=largeGraphGap;
   }
   if(lineHeight>0)
   //draws a horizontal line to compare the selected species' stat total to others.
   {
     line(sideBorder,height-topBorder-lineHeight,width-sideBorder,height-topBorder-lineHeight);
   }
}
