//////////////////////////////////////////////////////////////
// Date: 4/4/2025
// Design: Zip tie attached cable tags.
/////////////////////////////////////////////////////////////

// Standard BOSL2 Library REQUIRED to run!
// https://github.com/BelfrySCAD/BOSL2
include <BOSL2/std.scad>

/*
Design and Content property of Gary Blessing, aka the Alaskan Adventurer, Adventure Engineering.
I hope you enjoy it!

my website:
http://www.ak-adventurer.net

my page at printables.com:
https://www.printables.com/social/398111-ak-adventurer

This work is licensed under a Creative Commons 4.0 International License Attribution-NonCommercial.

NO Sharing without ATTRIBUTION
Remix Culture allowed
NO Commercial Use
NOT Free Cultural Works
DOES NOT Meet Open Definition

MEANING:
Just respect my time and energy that went into this code. More or less, remix as you like,
edit as you like. Don't sell it or sell anything it makes, and if you share this code or
items it makes, remixes, etc, please give me credit. Go read the license!
*/

//////////////////////////////////////////////////////////////
// Parameters

// Text height in mm.
TextSize = 9;
TS = TextSize;

// Text to print. All uppercase is much easier; less adjusting of padding is usually needed.
LabelText = "LAPTOP";
TextLength = len(LabelText);
echo(TextLength);

// Literal scale of text length used to size the tag base. 1.0 = 100%.
TagLengthScalar = 1.0; // 0.65

// Another way to adjust base length. Positive or negative number.
// 1 unit is half TextSize, roughly half one character long.
LengthPadding = 0.5;
Pad = LengthPadding * (TextSize / 2);

// Padding for tag height (useful for emoji/dingbats with unusual metrics), in mm.
WidthPadding = 0;
WPad = WidthPadding;

TagLength = ((TextLength * TextSize) * TagLengthScalar) + Pad;
echo(TagLength);

// Width of the rim around the text.
Rim = 0.8;

Width = TS + (Rim * 2) + 1 + WPad;
W = Width;

Length = TagLength;
L = Length;

// Thickness of the tag. Text and rim height are half of this.
Thickness = 1.8;
T = Thickness;

// Font to use. Dingbats welcome, if you have them.
FONT = "Constantia:style=Bold Italic"; // ["Constantia:style=Bold Italic", "Helvetica"]

// Text anchor type passed to BOSL2 text3d().
TextBase = "baseline"; // ["ycenter", "baseline"]

// Special-case vertical text shift, in mm.
TextVerticalOffset = 0;
TVO = TextVerticalOffset;

TextExtrusionHeight = T / 2;
TxH = TextExtrusionHeight;

// Length of tie slots, in mm.
ZipTieSlotLength = 5;
ZTL = ZipTieSlotLength;

// Width of tie slots, in mm (strap thickness + clearance).
ZipTieSlotWidth = 3;
ZTW = ZipTieSlotWidth;

// Thicker area where the tie sits, for reinforcing.
ZipTiePads = true;

// Put tie holes on one end, or both?
TwoTies = true;

// Optional extension point for remixes.
module EndCustomizer() {}

/////////////////////////////////////////////////////////////

TieTag();

module TieTag() {
  base_length = L + (TwoTies ? (ZTL * 2) : ZTL);
  slot_x = (L / 2) - (TwoTies ? 0 : (ZTL / 2));

  // Text emboss
  back(TVO)
  right(TwoTies ? 0 : (ZTL / 2))
  fwd(TS/2)
  up(T/2)
  text3d(LabelText, h=TxH, size=TS, font=FONT, anchor=BOT, atype=TextBase);

  // Tag body with slot cutouts and optional reinforcement pads.
  diff()
  cuboid([base_length, W, T/2], anchor=BOT, rounding=3,
    edges=[LEFT, RIGHT], except=[TOP, BOT]) {

    tag("keep")
    attach(TOP, BOT)
    rect_tube(T/2, size=[base_length, W], wall=Rim, irounding=3, rounding=[3,3,3,3]);

    tag("remove")
    if (TwoTies) xflip_copy()
    yflip_copy()
    fwd(TS/3)
    left(slot_x)
    attach(CTR, CTR)
    cuboid([ZTL, ZTW, T], anchor=CTR+BACK+RIGHT, rounding=1,
      edges=[LEFT, RIGHT], except=[TOP, BOT]);

    if (ZipTiePads) {
      tag("keep")
      if (TwoTies) xflip_copy()
      left(slot_x)
      attach(TOP, BOT)
      cuboid([ZTL+2, TS/3, T/2], anchor=CTR+RIGHT, rounding=1,
        edges=[LEFT, RIGHT], except=[TOP, BOT]);
    }
  }

  EndCustomizer();
}

//////////////////////////////////////////////////////////////
// End File.
//////////////////////////////////////////////////////////////
