/* config.h for bipolarbar.c */
#ifndef CONFIG_H
#define CONFIG_H

#define TOP_BAR 0        // 0=Bar at top, 1=Bar at bottom
#define BAR_HEIGHT 16
#define BAR_WIDTH 0      // 0=Full width or use num pixels
// If font isn't found "fixed" will be used
// #define FONT "-*-terminusmod.icons-medium-r-*-*-12-*-*-*-*-*-*-*,-*-stlarch-medium-r-*-*-12-*-*-*-*-*-*-*"
#define FONT "-*-terminus-medium-r-*-*-14-*-*-*-*-*-*-*"
#define FONTS_ERROR 1      // 0 to have missing fonts error shown
// colours are for background and the text
#define colour0 "#000000"  // &0 Default Background colour - original is #003040
#define colour1 "#7f7f7f"   // &1 Default foreground colour
#define colour2 "#b3b3b3"  // &2
#define colour3 "#999999"
#define colour4 "#cccccc"
#define colour5 "#444444"
#define colour6 "#555555"
#define colour7 "#666666"
#define colour8 "#1c678c"
#define colour9 "#ff950e"  // &9

#endif
