//////////////////////////////////////////////////////////////
//Date; 4/4/2025
//Design; Zip tie attached cable tags.
/////////////////////////////////////////////////////////////

//Standard BOSL2 Library REQUIRED to run!
//   https://github.com/BelfrySCAD/BOSL2
include <BOSL2/std.scad>

/*  Design and Content property of Gary Blessing, aka the Alaskan Adventurer, Adventure Engineering.  I hope you enjoy it!
my website;
http://www.ak-adventurer.net

my page at printables.com
https://www.printables.com/social/398111-ak-adventurer

This work is licensed under a
Creative Commons 4.0 International License
Attribution-NonCommercial

NO Sharing without ATTRIBUTION
Remix Culture allowed
NO Commercial Use
NOT Free Cultural Works
DOES NOT Meet Open Definition

MEANING;  Just respect my time and energy that went into this code.   :-D More or less, remix as you like, edit as you like. Don't sell it or sell anything it makes, and if you share this code or items it makes, or remixes, etc, Give me credit. Go read the license!

*/
//////////////////////////////////////////////////////////////
//Parameters

//Text Height in mm.
TextSize=9;
TS=TextSize;

//Text to print. All uppercase is much easier, less adjusting of Padding needed below.
String = "LAPTOP";
TextLength = len(String);
echo(TextLength);

//Literal scale of length of characters... 1.0=100% adjusts length of tag base.
TagLengthScalar=1.0;//0.65

// another way to adjust length of base. positive or negative numbers. 1 unit is half TextSize, or roughly half one character long, more or less, except in dingbats.. they are non standard
LengthPadding=0.5;
Pad=LengthPadding*(TextSize/2);

//Pading for height of tag, ie, if you use emoji or dingbats that are Not to point or mm specs. Acomodates taller text.  This one is 1= 1mm.
WidthPadding=0;
WPad=WidthPadding;

TagLength=((TextLength*TextSize)*TagLengthScalar)+Pad;
echo(TagLength);

//Width of the rim around the text.
Rim=0.8;

Width=TS+(Rim*2)+1+WPad;
W=Width;

Length=TagLength;
L=Length;

//Thickness of the tag. Text and rim height is half this.
Thickness=1.8;
T=Thickness;

//Font to use. Dingbats welcome, if you have them!
FONT="Constantia:style=Bold Italic";//["Constantia:style=Bold Italic", "Helvetica"]

//what is the bottom of the text? Base line is as if the text was typed on a line.. ycenter is center of its height. More or less.  baseline is default.
TextBase="baseline";//["ycenter","baseline"]

//use this to adjust for more special cases, like dingbats.. Positive or Negative +/- text up or down, in mm .
TextVerticalOffset=0;
TVO=TextVerticalOffset;

TextExtrusionHeight=T/2;
TxH=TextExtrusionHeight;

//length of the slots for the ties, in mm.
ZipTieSlotLength=5;
ZTL=ZipTieSlotLength;

ZTLS=ZTL;

//Width of the slots for the ties, or thickness of your zip tie strap(add a little for clearance!) in mm .
ZipTieSlotWidth=3;
ZTW=ZipTieSlotWidth;

//Thicker area where the tie sits, for reinforcing.
ZipTiePads=true;

//Do you want the tie holes on one end, or both?
TwoTies=true;

module EndCustomizer(){}


/////////////////////////////////////////////////////////////

TieTag();

module TieTag() {
  if(TwoTies){

    back(TVO)
    fwd(TS/2)
    up(T/2)
    text3d(String, h=TxH, size=TS, font=FONT, anchor=BOT, atype=TextBase);

  }
  else {
    back(TVO)
    right(ZTLS/2)
    fwd(TS/2)
    up(T/2)
    text3d(String, h=TxH, size=TS, font=FONT, anchor=BOT, atype=TextBase);

  }//else
  //



  if(TwoTies){

    diff()
    cuboid([L+(ZTLS*2), W, T/2], anchor=BOT, rounding=3,
      edges=[LEFT, RIGHT], except=[TOP, BOT] )
    {
      tag("keep")
      attach(TOP,BOT)
      rect_tube(T/2, size=[L+(ZTLS*2),W], wall=Rim, irounding=3, rounding=[3,3,3,3]);

      tag("remove")
      xflip_copy()
      yflip_copy()
      fwd(TS/3)
      left(((L)/2))
      attach(CTR,CTR)
      cuboid([ZTL, ZTW, T], anchor=CTR+BACK+RIGHT, rounding=1,
        edges=[LEFT, RIGHT], except=[TOP, BOT] );



      if(ZipTiePads){
        tag("keep")
        xflip_copy()
        left(((L)/2))
        attach(TOP,BOT)
        cuboid([ZTL+2, TS/3, T/2], anchor=CTR+RIGHT, rounding=1,
          edges=[LEFT, RIGHT], except=[TOP, BOT] );


      }//If
      //

    };//Cuboid
    //



  }//IF
  //

  else {
    diff()
    cuboid([L+(ZTLS), W, T/2], anchor=BOT, rounding=3,
      edges=[LEFT, RIGHT], except=[TOP, BOT] )
    {
      tag("keep")
      attach(TOP,BOT)
      rect_tube(T/2, size=[L+(ZTLS),W], wall=Rim, irounding=3, rounding=[3,3,3,3]);

      tag("remove")
      yflip_copy()
      fwd(TS/3)
      left(((L)/2)-(ZTLS/2))
      attach(CTR,CTR)
      cuboid([ZTL, ZTW, T], anchor=CTR+BACK+RIGHT, rounding=1,
        edges=[LEFT, RIGHT], except=[TOP, BOT] );

      if(ZipTiePads){
        tag("keep")
        left(((L)/2)-(ZTLS/2))
        attach(TOP,BOT)
        cuboid([ZTL+2, TS/3, T/2], anchor=CTR+RIGHT, rounding=1,
          edges=[LEFT, RIGHT], except=[TOP, BOT] );
      }//If
      //

    };//Cuboid
    //

  }//Else
  //

}//M
//


//////////////////////////////////////////////////////////////
//End File.
//////////////////////////////////////////////////////////////
