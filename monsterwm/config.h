/* see LICENSE for copyright and license */

#ifndef CONFIG_H
#define CONFIG_H

/** modifiers **/
#define MOD1            Mod1Mask    /* ALT key */
#define MOD4            Mod4Mask    /* Super/Windows key */
#define CONTROL         ControlMask /* Control key */
#define SHIFT           ShiftMask   /* Shift key */

/** generic settings **/
#define MASTER_SIZE     0.52
#define SHOW_PANEL      True      /* show panel by default on exec */
#define TOP_PANEL       True      /* False means panel is on bottom */
#define PANEL_HEIGHT    16        /* 0 for no space for panel, thus no panel */
#define DEFAULT_MODE    TILE      /* initial layout/mode: TILE MONOCLE BSTACK GRID FLOAT */
#define ATTACH_ASIDE    False      /* False means new window is master */
#define FOLLOW_WINDOW   True     /* follow the window when moved to a different desktop */
#define FOLLOW_MOUSE    True      /* focus the window the mouse just entered */
#define CLICK_TO_FOCUS  True      /* focus an unfocused window when clicked  */
#define BORDER_WIDTH    1         /* window border width */
#define FOCUS           "#000ac9" /* focused window border color    */
#define UNFOCUS         "#444444" /* unfocused window border color  */
#define MINWSZ          50        /* minimum window size in pixels  */
#define DEFAULT_DESKTOP 0         /* the desktop to focus initially */
#define DESKTOPS        4         /* number of desktops - edit DESKTOPCHANGE keys to suit */

/**
 * open applications to specified desktop with specified mode.
 * if desktop is negative, then current is assumed
 */
static const AppRule rules[] = { \
    /*  class     desktop  follow  float */
    { "MPlayer",     3,    True,   False },
    { "Gimp",        0,    False,  True  },
};

/* helper for spawning shell commands */
#define SHCMD(cmd) {.com = (const char*[]){"/bin/sh", "-c", cmd, NULL}}

/**
 * custom commands
 * must always end with ', NULL };'
 */
static const char *termcmd[] = { "urxvt",     NULL };
static const char *terminatorcmd[] = { "terminator",     NULL };
static const char *menucmd[] = { "dmenu_run", "-fn", "-*-terminus-medium-r-*-*-14-*-*-*-*-*-*-*", NULL };
static const char *filemanagercmd[] = { "thunar", NULL };
static const char *lockcmd[] = { "/home/rob/bin/lock", NULL };
static const char *uzblcmd[] = { "uzbl", NULL };
static const char *xonoticcmd[] = { "xonotic-glx", NULL };
static const char *solcmd[] = { "sol", NULL };
static const char *imagecmd[] = { "mirage", NULL };
static const char *geanycmd[] = { "geany", NULL };
static const char *leafpadcmd[] = { "leafpad", NULL };
static const char *vlccmd[] = { "vlc", NULL };
static const char *keepasscmd[] = { "keepassx", NULL };
static const char *calccmd[] = { "speedcrunch", NULL };
static const char *chromiumcmd[] = { "chromium", NULL };
static const char *officecmd[] = { "libreoffice", NULL };
static const char *hugincmd[] = { "hugin", NULL };
static const char *alsacmd[] = { "urxvt", "-e", "alsamixer", NULL };
static const char *digikamcmd[] = { "digikam", NULL };

#define DESKTOPCHANGE(K,N) \
    {  MOD1,             K,              change_desktop, {.i = N}}, \
    {  MOD1|ShiftMask,   K,              client_to_desktop, {.i = N}},

/**
 * keyboard shortcuts
 */
static Key keys[] = {
    /* modifier          key            function           argument */
    /* APPICATION KEYBINDINGS */
    {  MOD1,             XK_a,          spawn,             {.com = alsacmd}},           
    {  MOD1,             XK_b,          togglepanel,       {NULL}},         
    {  MOD1,             XK_c,          spawn,             {.com = chromiumcmd}},           
    {  MOD1,             XK_d,          spawn,             {.com = digikamcmd}},           
    {  MOD1,             XK_e,          spawn,             {.com = terminatorcmd}},          
    {  MOD1,             XK_f,          spawn,             {.com = filemanagercmd}},           
    {  MOD1,             XK_g,          spawn,             {.com = geanycmd}},          
    {  MOD1,             XK_h,          spawn,             {.com = hugincmd}},              
    {  MOD1,             XK_i,          spawn,             {.com = imagecmd}},           
 /* {  MOD1,             XK_j,  */         
    {  MOD1,             XK_k,          spawn,             {.com = keepasscmd}},           
    {  MOD1,             XK_l,          spawn,             {.com = leafpadcmd}},          
    {  MOD1,             XK_m,          spawn,             {.com = menucmd}},          
 /* {  MOD1,             XK_n,  */         
    {  MOD1,             XK_o,          spawn,             {.com = officecmd}},            
 /* {  MOD1,             XK_p,  */         
 /* {  MOD1,             XK_q,  */       
 /* {  MOD1,             XK_r,  */       
    {  MOD1,             XK_s,          spawn,             {.com = solcmd}},          
    {  MOD1,             XK_t,          spawn,             {.com = termcmd}},          
    {  MOD1,             XK_u,          spawn,             {.com = uzblcmd}},          
    {  MOD1,             XK_v,          spawn,             {.com = vlccmd}},          
 /* {  MOD1,             XK_w,  */        
    {  MOD1,             XK_x,          spawn,             {.com = xonoticcmd}},          
 /* {  MOD1,             XK_y,  */
 /* {  MOD1,             XK_z,  */
    
    {  MOD1,             XK_BackSpace,  focusurgent,       {NULL}},

    {  MOD1|SHIFT,       XK_c,          killclient,        {NULL}},        
      
    /* {  MOD1,             XK_h,          resize_master,     {.i = -10}}, */ /* decrease size in px */
    /* {  MOD1,             XK_l,          resize_master,     {.i = +10}}, */ /* increase size in px */
    /* {  MOD1,             XK_o,          resize_stack,      {.i = -10}}, */ /* shrink   size in px */
    /* {  MOD1,             XK_p,          resize_stack,      {.i = +10}}, */ /* grow     size in px */    
    {  MOD1,             XK_Tab,        last_desktop,      {NULL}},
    {  MOD1,             XK_Return,     swap_master,       {NULL}},    

    /* {  MOD1|SHIFT,       XK_h,          rotate_filled,     {.i = -1}}, */
    /* {  MOD1|SHIFT,       XK_l,          rotate_filled,     {.i = +1}},   */  
    /* {  MOD1|SHIFT,       XK_j,          move_down,         {NULL}}, */
    /* {  MOD1|SHIFT,       XK_k,          move_up,           {NULL}}, */

    {  MOD1|CONTROL,     XK_h,          rotate,            {.i = -1}},
    {  MOD1|CONTROL,     XK_l,          rotate,            {.i = +1}},

    {  MOD4,             XK_j,          next_win,          {NULL}},
    {  MOD4,             XK_k,          prev_win,          {NULL}},

    {  MOD4,             XK_t,          switch_mode,       {.i = TILE}},
    {  MOD4,             XK_m,          switch_mode,       {.i = MONOCLE}},
    {  MOD4,             XK_b,          switch_mode,       {.i = BSTACK}},
    {  MOD4,             XK_g,          switch_mode,       {.i = GRID}},
    {  MOD4,             XK_f,          switch_mode,       {.i = FLOAT}},

    /* {  MOD4|CONTROL      XK_j,          moveresize,        {.v = (int []){   0,  25,   0,   0 }}}, */ /* move up    */
    /* {  MOD4|CONTROL      XK_k,          moveresize,        {.v = (int []){   0, -25,   0,   0 }}}, */ /* move down  */
    /* {  MOD4|CONTROL      XK_l,          moveresize,        {.v = (int []){  25,   0,   0,   0 }}}, */ /* move right */
    /* {  MOD4|CONTROL      XK_h,          moveresize,        {.v = (int []){ -25,   0,   0,   0 }}}, */ /* move left  */

    {  MOD4|CONTROL,     XK_r,          quit,              {.i = 0}}, /* quit with exit value 0 */
    {  MOD4|CONTROL,     XK_q,          quit,              {.i = 1}}, /* quit with exit value 1 */
    {  MOD4|CONTROL,     XK_l,          spawn,             {.com = lockcmd}},

    /* {  MOD4|SHIFT,       XK_j,          moveresize,        {.v = (int []){   0,   0,   0,  25 }}}, */ /* height grow   */
    /* {  MOD4|SHIFT,       XK_k,          moveresize,        {.v = (int []){   0,   0,   0, -25 }}}, */ /* height shrink */
    /* {  MOD4|SHIFT,       XK_l,          moveresize,        {.v = (int []){   0,   0,  25,   0 }}}, */ /* width grow    */
    /* {  MOD4|SHIFT,       XK_h,          moveresize,        {.v = (int []){   0,   0, -25,   0 }}}, */ /* width shrink  */

       DESKTOPCHANGE(    XK_F1,                             0)
       DESKTOPCHANGE(    XK_F2,                             1)
       DESKTOPCHANGE(    XK_F3,                             2)
       DESKTOPCHANGE(    XK_F4,                             3)
};

/**
 * mouse shortcuts
 */
static Button buttons[] = {
    {  MOD1,    Button1,     mousemotion,   {.i = MOVE}},
    {  MOD1,    Button3,     mousemotion,   {.i = RESIZE}},
    {  MOD4,    Button3,     spawn,         {.com = menucmd}},
};
#endif
