/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
static int centered = 1;                    /* -c option; centers dmenu on screen */
static int min_width = 1000;                    /* minimum width when centered */
static const float menu_height_ratio = 4.5f;  /* This is the ratio used in the original calculation */
static int fuzzy  = 1;                      /* -F  option; if 0, dmenu doesn't use fuzzy matching */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
	"monospace:size=10"
};
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
	/*     fg         bg       */
	[SchemeNorm] = { "#bbbbbb", "#222222" },
	[SchemeSel] = { "#eeeeee", "#005577" },
	[SchemeSelHighlight] = { "#ffc978", "#005577" },
	[SchemeNormHighlight] = { "#ffc978", "#222222" },
	[SchemeOut] = { "#000000", "#00ffff" },
	[SchemeCursor] = { "#222222", "#bbbbbb"},
};
/* -l and -g options; controls number of lines and columns in grid if > 0 */
static unsigned int lines      = 0;
static unsigned int columns    = 0;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";
/* Size of the window border */
static unsigned int border_width = 4;

/*
 * -vi option; if nonzero, vi mode is always enabled and can be
 * accessed with the global_esc keysym + mod mask
 */
static unsigned int vi_mode = 1;
static unsigned int start_mode = 0;			/* mode to use when -vi is passed. 0 = insert mode, 1 = normal mode */
static Key global_esc = { XK_n, Mod1Mask };	/* escape key when vi mode is not enabled explicitly */
static Key quit_keys[] = {
	/* keysym	modifier */
	{ XK_q,		0 }
};
