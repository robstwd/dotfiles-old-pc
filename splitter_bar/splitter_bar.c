/* splitter_bar.c
*
*  This program is free software: you can redistribute it and/or modify
*  it under the terms of the GNU General Public License as published by
*  the Free Software Foundation, either version 2 of the License, or
*  (at your option) any later version.
*
*  This program is distributed in the hope that it will be useful,
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*  GNU General Public License for more details.
*
*  You should have received a copy of the GNU General Public License
*  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*
*/

#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <X11/Xatom.h>
#include <X11/Xlocale.h>

#include <stdio.h>
#include <stdlib.h>
#include <locale.h>
#include <string.h>
#include <signal.h>
#include <sys/select.h>
#include <sys/time.h>
#include <unistd.h>

/***************** DEFINES ***********************/
#define TOP_BAR 0        // 0=Bar at top, 1=Bar at bottom
#define BAR_HEIGHT 16
#define BAR_WIDTH 0      // 0=Full width or use num pixels
// If font isn't found "fixed" will be used
// #define FONT "-*-terminusmod.icons-medium-r-*-*-12-*-*-*-*-*-*-*,-*-stlarch-medium-r-*-*-12-*-*-*-*-*-*-*" // original value
#define FONT "-*-terminus-medium-r-*-*-14-*-*-*-*-*-*-*"					// font from dwm
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

typedef struct {
    unsigned long color;
    GC gc;
} Theme;
static Theme theme[10];

typedef struct {
    XFontStruct *font;          /* font structure */
    XFontSet fontset;           /* fontset structure */
    int height;                 /* height of the font */
    int width;
    unsigned int fh;            /* Y coordinate to draw characters */
    unsigned int ascent;
    unsigned int descent;
} Iammanyfonts;

static void get_font();
static void update_right();
static void print_text();
static void print_right_text();
static int wc_size(char *string, int num);

static const char *defaultcolor[] = { colour0, colour1, colour2, colour3, colour4, colour5, colour6, colour7, colour8, colour9, };
static const char *font_list = FONT;

static unsigned int count, counted, j, k, m, bg;
static unsigned int text_length, text_start, new_length;
static unsigned int old_length;
static char output[256] = {"splitter_Bar "};
static char right[256] = {"You're ad here "};

static Display *dis;
static unsigned int sw;
static unsigned int sh;
static unsigned int height;
static unsigned int width;
static unsigned int screen;
static Window root;
static Window barwin;
static Drawable winbar;

static Iammanyfonts font;

void get_font() {
	char *def, **missing;
	int i, n;

	missing = NULL;
	if(strlen(font_list) > 0)
	    font.fontset = XCreateFontSet(dis, (char *)font_list, &missing, &n, &def);
	if(missing) {
		if(FONTS_ERROR < 1)
            while(n--)
                fprintf(stderr, ":: Splitter_bar :: missing fontset: %s\n", missing[n]);
		XFreeStringList(missing);
	}
	if(font.fontset) {
		XFontStruct **xfonts;
		char **font_names;

		font.ascent = font.descent = 0;
		n = XFontsOfFontSet(font.fontset, &xfonts, &font_names);
		for(i = 0, font.ascent = 0, font.descent = 0; i < n; i++) {
			if (font.ascent < (*xfonts)->ascent) font.ascent = (*xfonts)->ascent;
            if (font.descent < (*xfonts)->descent) font.descent = (*xfonts)->descent;
			xfonts++;
		}
		font.width = XmbTextEscapement(font.fontset, " ", 1);
	} else {
		fprintf(stderr, ":: Splitter_bar :: Font '%s' Not Found\n:: Splitter_bar :: Trying Font 'Fixed'\n", font_list);
		if(!(font.font = XLoadQueryFont(dis, font_list))
		&& !(font.font = XLoadQueryFont(dis, "fixed")))
			fprintf(stderr, ":: Splitter_bar :: Error, cannot load font: '%s'\n", font_list);
		font.ascent = font.font->ascent;
		font.descent = font.font->descent;
		font.width = XTextWidth(font.font, " ", 1);
	}
	font.height = font.ascent + font.descent;
}

void update_output() {
    j=1; k=0; bg = 0;
    text_length = 0;
    unsigned int n;
    ssize_t num;
    char win_name[256];

    for(k=0;k<257;k++)
        output[k] = '\0';
    if(!(num = read(STDIN_FILENO, output, sizeof(output)))) {
        fprintf(stderr, "Splitter_bar :: FAILED TO READ STDIN!!\n");
        strncpy(output, "FAILED TO READ STDIN!!", 24);
        exit(1);
    }

    count = 0; k = 0;
    text_length = strlen(output);
    for(n=0;n<=text_length;n++) {
        while(output[n] == '&') {
            if(output[n+1]-'0' < 10 && output[n+1]-'0' >= 0)
                n += 2;
            if(output[n+1] == 'B' && output[n+2]-'0' < 10 && output[n+2]-'0' >= 0)
                n += 3;
        }
        if(output[n] == '\n' || output[n] == '\r') break;
        win_name[count] = output[n];
        count++;
    }
    new_length = wc_size(win_name, count);
    XFillRectangle(dis, winbar, theme[0].gc, 0, 0, old_length, height);
    for(count=0;count<=text_length;count++) {
        print_text();
    }
    XCopyArea(dis, winbar, barwin, theme[1].gc, 0, 0, new_length, height, 0, 0);
    XSync(dis, False);
    old_length = new_length;
    return;
}

void update_right() {
    unsigned int text_l=0, p_length, q=0, n;
    char bstring[256];
    char *root_name;
    j=1;m=0; bg = 0;

    if(!(XFetchName(dis, root, &root_name))) {
        strcpy(right, "&3splitter_bar ");
        text_l = 14;
    } else {
        while(root_name[text_l] != '\0' && text_l < 256) {
            right[text_l] = root_name[text_l];
            text_l++;
        }
        right[text_l] = '\0';
    }
    XFree(root_name);

    XFillRectangle(dis, winbar, theme[0].gc, old_length, 0, width-old_length, height);
    text_start = old_length+font.width;
    // i=pos on screen q=pos in text
    for(counted=0;counted<=text_l;counted++) {
        if(right[counted] == '&' && (right[counted+1] == 'C' || right[counted+1] == 'R')) {
            counted += 2; q=0; m=0;
            for(n=counted;n<text_l;n++) {
                while(right[n] == '&') {
                    if(right[n+1]-'0' < 10 && right[n+1]-'0' >= 0) {
                        n += 2;
                    } else if(right[n+1] == 'B' && right[n+2]-'0' < 10 && right[n+2]-'0' >= 0) {
                        n += 3;
                    } else if(right[n+1] == 'R') {
                        break;
                    } else break;
                }
                bstring[q] = right[n]; q++;
            }
            bstring[q] = '\0';
            p_length = wc_size(bstring, q);
            if(right[counted-1] == 'C')
                text_start = (width/2)-(p_length/2)+old_length;
            if(right[counted-1] == 'R')
                text_start = width-p_length;
        }
        print_right_text();
    }

    XCopyArea(dis, winbar, barwin, theme[1].gc, old_length, 0, width-old_length, height, old_length, 0);
    for(n=0;n<256;n++)
        right[n] ='\0';
    XSync(dis, False);
    return;
}

void print_right_text() {
    char bstring[256];
    unsigned int wsize, n=0;

    while(right[counted] == '&') {
        if(right[counted+1] == 'C' || right[counted+1] == 'R') {
            counted--;
            break;
        }
        if(right[counted+1]-'0' < 10 && right[counted+1]-'0' >= 0) {
            j = right[counted+1]-'0';
            counted += 2;
        } else if(right[counted+1] == 'B' && right[counted+2]-'0' < 10 && right[counted+2]-'0' >= 0) {
            bg = right[counted+2]-'0';
            counted += 3;
        } else break;
    }
    if(right[counted] == '&') {
        bstring[n] = right[counted];
        n++;counted++;
    }
    while(right[counted] != '&' && right[counted] != '\0' && right[counted] != '\n' && right[counted] != '\r') {
        bstring[n] = right[counted];
        n++;counted++;
    }
    if(n < 1) return;
    bstring[n] = '\0';
    wsize = wc_size(bstring, n);
    XFillRectangle(dis, winbar, theme[bg].gc, text_start+m, 0, wsize, height);
    if(font.fontset)
        XmbDrawString(dis, winbar, font.fontset, theme[j].gc, text_start+m, font.fh, bstring, n);
    else
        XDrawString(dis, winbar, theme[j].gc, text_start+m, font.fh, bstring, n);
    m += wsize;
    for(wsize=0;wsize<n;wsize++)
        bstring[wsize] = '\0';
    counted--;
}

void print_text() {
    char astring[256];
    unsigned int wsize, n=0;

    while(output[count] == '&') {
        if(output[count+1]-'0' < 10 && output[count+1]-'0' >= 0) {
            j = output[count+1]-'0';
            count += 2;
        } else if(output[count+1] == 'B' && output[count+2]-'0' < 10 && output[count+2]-'0' >= 0) {
            bg = output[count+2]-'0';
            count += 3;
        } else break;
    }
    if(output[count] == '&') {
        astring[n] = output[count];
        n++;count++;
    }
    while(output[count] != '&' && output[count] != '\0' && output[count] != '\n' && output[count] != '\r') {
        astring[n] = output[count];
        n++;count++;
    }
    if(n < 1) return;
    astring[n] = '\0';
    wsize = wc_size(astring, n);
    XFillRectangle(dis, winbar, theme[bg].gc, k, 0, wsize, height);
    if(font.fontset)
        XmbDrawString(dis, winbar, font.fontset, theme[j].gc, k, font.fh, astring, n);
    else
        XDrawString(dis, winbar, theme[j].gc, k, font.fh, astring, n);
    k += wsize;
    for(wsize=0;wsize<n;wsize++)
        astring[wsize] = '\0';
    count--;
}

int wc_size(char *string, int num) {
    XRectangle rect;

    if(font.fontset) {
        XmbTextExtents(font.fontset, string, num, NULL, &rect);
        return rect.width;
    } else {
        return XTextWidth(font.font, string, num);
    }
}

unsigned long getcolor(const char* color) {
    XColor c;
    Colormap map = DefaultColormap(dis,screen);

    if(!XAllocNamedColor(dis,map,color,&c,&c)) {
        fprintf(stderr, "\033[0;31mSplitter_bar :: Error parsing color!");
        return 1;
    }
    return c.pixel;
}

int main(int argc, char ** argv){
    unsigned int i, y = 0;
    XEvent ev;
    XSetWindowAttributes attr;
	char *loc;
	fd_set readfds;
    struct timeval tv;

    dis = XOpenDisplay(NULL);
    if (!dis) {fprintf(stderr, "Splitter_bar :: unable to connect to display");return 7;}

    root = DefaultRootWindow(dis);
    screen = DefaultScreen(dis);
    sw = XDisplayWidth(dis,screen);
    sh = XDisplayHeight(dis,screen);
    loc = setlocale(LC_ALL, "");
    if (!loc || !strcmp(loc, "C") || !strcmp(loc, "POSIX") || !XSupportsLocale())
        fprintf(stderr, "Splitter_bar :: LOCALE FAILED\n");
    get_font();
    height = (BAR_HEIGHT > font.height) ? BAR_HEIGHT : font.height+2;
    font.fh = ((height - font.height)/2) + font.ascent;
    width = (BAR_WIDTH == 0) ? sw : BAR_WIDTH;
    if (TOP_BAR != 0) y = sh - height;

    for(i=0;i<10;i++)
        theme[i].color = getcolor(defaultcolor[i]);
    XGCValues values;

    for(i=0;i<10;i++) {
        values.foreground = theme[i].color;
        values.line_width = 2;
        values.line_style = LineSolid;
        if(font.fontset) {
            theme[i].gc = XCreateGC(dis, root, GCBackground|GCForeground|GCLineWidth|GCLineStyle,&values);
        } else {
            values.font = font.font->fid;
            theme[i].gc = XCreateGC(dis, root, GCBackground|GCForeground|GCLineWidth|GCLineStyle|GCFont,&values);
        }
    }
    old_length = 0;

    winbar = XCreatePixmap(dis, root, width, height, DefaultDepth(dis, screen));
    XFillRectangle(dis, winbar, theme[0].gc, 0, 0, width, height);
    barwin = XCreateSimpleWindow(dis, root, 0, y, width, height, 0, theme[0].color,theme[0].color);
    attr.override_redirect = True;
    XChangeWindowAttributes(dis, barwin, CWOverrideRedirect, &attr);
    XSelectInput(dis,barwin,ExposureMask);
    XSelectInput(dis,root,PropertyChangeMask);
    XMapWindow(dis, barwin);
    int x11_fd = ConnectionNumber(dis);
    while(1){
       	FD_ZERO(&readfds);
        FD_SET(x11_fd, &readfds);
        FD_SET(STDIN_FILENO, &readfds);
        tv.tv_sec = 0;
        tv.tv_usec = 200000;
        select(x11_fd+1, &readfds, NULL, NULL, &tv);

    	if (FD_ISSET(STDIN_FILENO, &readfds))
    	    update_output();
        while(XPending(dis) != 0) {
            XNextEvent(dis, &ev);
            switch(ev.type){
                case Expose:
                    XCopyArea(dis, winbar, barwin, theme[1].gc, 0, 0, width, height, 0, 0);
                    XSync(dis, False);
                    break;
                case PropertyNotify:
                    if(ev.xproperty.window == root && ev.xproperty.atom == XA_WM_NAME)
                        update_right();
                    break;
            }
        }
    }

    return (0);
}
