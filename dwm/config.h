/* See LICENSE file for copyright and license details. */
// clang-format off

#define SESSION_FILE "/tmp/dwm-session"

/* appearance */
static unsigned int borderpx  = 3;        /* border pixel of windows */
static unsigned int snap      = 0;       /* snap pixel */
static int showbar            = 1;        /* 0 means no bar */
static int topbar             = 1;        /* 0 means bottom bar */
static const int focusonwheel       = 0;
static char font[]            = "FuraCode Nerd Font Mono:size=10";
static char dmenufont[]       = "FuraCode Nerd Font Mono:size=10";
static const char *fonts[] = {
          "monospace:size=10",
					"Noto Color Emoji:size:16",
					"FuraCode Nerd Font Mono:size=10",
					"Source Han Sans:size=10",
					};
static char normbgcolor[]           = "#222222";
static char normbordercolor[]       = "#000000";
static char normfgcolor[]           = "#bbbbbb";
static char selfgcolor[]            = "#eeeeee";
static char selbordercolor[]        = "#2283f2";
static char selbgcolor[]            = "#005577";

enum { SchemeNorm, SchemeCol1, SchemeCol2, SchemeCol3, SchemeCol4,
       SchemeCol5, SchemeCol6, SchemeSel }; /* color schemes */

static char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm]  = { normfgcolor,      normbgcolor, normbordercolor },
	[SchemeCol1]  = { normfgcolor,      normbgcolor, normbordercolor },
	[SchemeCol2]  = { normfgcolor,      normbgcolor, normbordercolor },
	[SchemeCol3]  = { normfgcolor,      normbgcolor, normbordercolor },
	[SchemeCol4]  = { normfgcolor,      normbgcolor, normbordercolor },
	[SchemeCol5]  = { normfgcolor,      normbgcolor, normbordercolor },
	[SchemeCol6]  = { normfgcolor,      normbgcolor, normbordercolor },
	[SchemeSel]  = { selfgcolor,  selbgcolor,  selbordercolor  },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	 /* class      instance    title       tags mask     isfloating   monitor    float x,y,w,h         floatborderpx*/
	{ "nannou",   NULL,       NULL,       0,            1,           -1,        -1,-1,-1,-1,           -1 },
	{ "gnuplot-qt", NULL,     NULL,       0,            1,           -1,        -1,-1,-1,-1,           -1 },
	{ "Gimp",     NULL,       NULL,       0,            1,           -1,        50,50,1000,1000,        5 },
	{ "Firefox",  NULL,       NULL,       1 << 8,       0,           -1,        50,50,500,500,          5 },
	{ "St",       NULL, "floating",       0,            1,           -1,        -1,-1,-1,-1,            5 },
};

/* layout(s) */
static float mfact     = 0.50; /* factor of master area size [0.05..0.95] */
static int nmaster     = 1;    /* number of clients in master area */
static int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */
static const int attachdirection = 3;    /* 0 default, 1 above, 2 aside, 3 below, 4 bottom, 5 top */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbordercolor, "-sf", selfgcolor, NULL };
static const char *termcmd[]  = { "st", NULL };

/*
 * Xresources preferences to load at startup
 */
ResourcePref resources[] = {
		{ "normbgcolor",        STRING,  &normbgcolor },
		{ "normbordercolor",    STRING,  &normbordercolor },
		{ "normfgcolor",        STRING,  &normfgcolor },
		{ "selbgcolor",         STRING,  &selbgcolor },
		{ "selbordercolor",     STRING,  &selbordercolor },
		{ "selfgcolor",         STRING,  &selfgcolor },
		{ "borderpx",          	INTEGER, &borderpx },
		{ "snap",           		INTEGER, &snap },
		{ "showbar",          	INTEGER, &showbar },
		{ "topbar",           	INTEGER, &topbar },
		{ "nmaster",          	INTEGER, &nmaster },
		{ "resizehints",       	INTEGER, &resizehints },
		{ "mfact",      	      FLOAT,   &mfact },
};

#include "movestack.c"
static Key keys[] = {
	/* modifier                     key        function        argument */
	{ Mod1Mask|MODKEY,         XK_1,      spawn,          SHCMD("changebg") },
	{ Mod1Mask|MODKEY,         XK_2,      spawn,          SHCMD("bgswap.sh") },
	{ Mod1Mask|MODKEY,         XK_3,      spawn,          SHCMD("dmenuEmoji.sh") },
	{ Mod1Mask|MODKEY,         XK_4,      spawn,          SHCMD("screenshot.sh --select") },
	{ Mod1Mask|MODKEY,         XK_5,      spawn,          SHCMD("screenshot.sh --blur") },
	{ Mod1Mask|MODKEY,         XK_6,      spawn,          SHCMD("screenshot.sh --hide") },
	{ Mod1Mask|MODKEY,         XK_7,      spawn,          SHCMD("screenshot.sh --full") },
	{ Mod1Mask|MODKEY,         XK_8,      spawn,          SHCMD("screenshot.sh --wiki") },
	{ Mod1Mask|MODKEY,         XK_g,      spawn,          SHCMD("screenshot.sh --pictures") },
	{ Mod1Mask|MODKEY,         XK_c,      spawn,          SHCMD("screen_to_clipboard.sh") },
	{ Mod1Mask|MODKEY,         XK_b,      spawn,          SHCMD("google-chrome-stable") },
	/* { Mod1Mask|MODKEY,         XK_w,      spawn,          SHCMD("qutebrowser") }, */
	{ Mod1Mask|MODKEY,         XK_s,      spawn,          SHCMD("steam") },
	{ Mod1Mask|MODKEY,         XK_d,      spawn,          SHCMD("discord") },
	{ Mod1Mask|MODKEY,         XK_p,      spawn,          SHCMD("pavucontrol") },
	{ Mod1Mask|MODKEY,         XK_f,      spawn,          SHCMD("thunar") },
	{ Mod1Mask|MODKEY,         XK_i,      spawn,          SHCMD("Audio_Swap.sh") },
	{ MODKEY,                       XK_Insert, spawn,          SHCMD("xdotool type $(grep -v '^#' ~/ssd/Documents/snippets | dmenu -i -l 50 | cut -d' ' -f1)") },
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_m,      spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_minus,  focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_equal,  focusstack,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_minus,  movestack,      {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_equal,  movestack,      {.i = -1 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY,                       XK_h,	   focusmon,       {.i = +1 } },
	{ MODKEY,                       XK_l,      focusmon,       {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_h,	   tagmon,         {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_l,	   tagmon,         {.i = -1 } },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_j,      movestack,      {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_k,      movestack,      {.i = -1 } },
	{ MODKEY,                       XK_n,      viewnext,       {0} },
	{ MODKEY,                       XK_t,      viewprev,       {0} },
	{ MODKEY|ShiftMask,             XK_n,	   tagtonext,      {0} },
	{ MODKEY|ShiftMask,             XK_t,	   tagtoprev,      {0} },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_o,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_u,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_y,      setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    togglecanfocusfloating,  {0} },
	{ MODKEY,                       XK_q,      killclient,     {0} },
	{ MODKEY|ControlMask,           XK_m,      killclient,     {0} },
	{ MODKEY,                       XK_d,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_s,      setlayout,      {.v = &layouts[2]} },
	/* { MODKEY,                       XK_space,  setlayout,      {+1} }, Causes segfault!!*/
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY|Mod1Mask,              XK_space,  togglealwaysontop, {0} },
	{ MODKEY,                       XK_Up,     moveresize,     {.v = "0x -25y 0w 0h" } },
	{ MODKEY,                       XK_Down,   moveresize,     {.v = "0x 25y 0w 0h" } },
	{ MODKEY,                       XK_Right,  moveresize,     {.v = "25x 0y 0w 0h" } },
	{ MODKEY,                       XK_Left,   moveresize,     {.v = "-25x 0y 0w 0h" } },
	{ MODKEY|ShiftMask,             XK_Down,   moveresize,     {.v = "0x 0y 0w 25h" } },
	{ MODKEY|ShiftMask,             XK_Up,     moveresize,     {.v = "0x 0y 0w -25h" } },
	{ MODKEY|ShiftMask,             XK_Right,  moveresize,     {.v = "0x 0y 25w 0h" } },
	{ MODKEY|ShiftMask,             XK_Left,   moveresize,     {.v = "0x 0y -25w 0h" } },
	{ MODKEY|ControlMask,           XK_Up,     moveresizeedge, {.v = "t"} },
	{ MODKEY|ControlMask,           XK_Down,   moveresizeedge, {.v = "b"} },
	{ MODKEY|ControlMask,           XK_Left,   moveresizeedge, {.v = "l"} },
	{ MODKEY|ControlMask,           XK_Right,  moveresizeedge, {.v = "r"} },
	{ MODKEY|ControlMask|ShiftMask, XK_Up,     moveresizeedge, {.v = "T"} },
	{ MODKEY|ControlMask|ShiftMask, XK_Down,   moveresizeedge, {.v = "B"} },
	{ MODKEY|ControlMask|ShiftMask, XK_Left,   moveresizeedge, {.v = "L"} },
	{ MODKEY|ControlMask|ShiftMask, XK_Right,  moveresizeedge, {.v = "R"} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|Mod1Mask|ControlMask|ShiftMask, XK_r,      quit,           {1} },
	{ MODKEY|Mod1Mask|ControlMask|ShiftMask, XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button1,        sigdwmblocks,   {.i = 1} },
	{ ClkStatusText,        0,              Button2,        sigdwmblocks,   {.i = 2} },
	{ ClkStatusText,        0,              Button3,        sigdwmblocks,   {.i = 3} },
	{ ClkClientWin,         ShiftMask,      Button1,        movemouse,      {0} },
	{ ClkClientWin,         ShiftMask,      Button2,        togglefloating, {0} },
	{ ClkClientWin,         ShiftMask,      Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};


static const char *ipcsockpath = "/tmp/dwm.sock";
static IPCCommand ipccommands[] = {
  IPCCOMMAND(  view,                1,      {ARG_TYPE_UINT}   ),
  IPCCOMMAND(  toggleview,          1,      {ARG_TYPE_UINT}   ),
  IPCCOMMAND(  tag,                 1,      {ARG_TYPE_UINT}   ),
  IPCCOMMAND(  toggletag,           1,      {ARG_TYPE_UINT}   ),
  IPCCOMMAND(  tagmon,              1,      {ARG_TYPE_UINT}   ),
  IPCCOMMAND(  focusmon,            1,      {ARG_TYPE_SINT}   ),
  IPCCOMMAND(  focusstack,          1,      {ARG_TYPE_SINT}   ),
  IPCCOMMAND(  zoom,                1,      {ARG_TYPE_NONE}   ),
  IPCCOMMAND(  incnmaster,          1,      {ARG_TYPE_SINT}   ),
  IPCCOMMAND(  killclient,          1,      {ARG_TYPE_SINT}   ),
  IPCCOMMAND(  togglefloating,      1,      {ARG_TYPE_NONE}   ),
  IPCCOMMAND(  setmfact,            1,      {ARG_TYPE_FLOAT}  ),
  IPCCOMMAND(  setlayoutsafe,       1,      {ARG_TYPE_PTR}    ),
  IPCCOMMAND(  quit,                1,      {ARG_TYPE_NONE}   )
};


void
setlayoutex(const Arg *arg)
{
	setlayout(&((Arg) { .v = &layouts[arg->i] }));
}

void
viewex(const Arg *arg)
{
	view(&((Arg) { .ui = 1 << arg->ui }));
}

void
viewall(const Arg *arg)
{
	view(&((Arg){.ui = ~0}));
}

void
toggleviewex(const Arg *arg)
{
	toggleview(&((Arg) { .ui = 1 << arg->ui }));
}

void
tagex(const Arg *arg)
{
	tag(&((Arg) { .ui = 1 << arg->ui }));
}

void
toggletagex(const Arg *arg)
{
	toggletag(&((Arg) { .ui = 1 << arg->ui }));
}

void
tagall(const Arg *arg)
{
	tag(&((Arg){.ui = ~0}));
}

/* signal definitions */
/* signum must be greater than 0 */
/* trigger signals using `xsetroot -name "fsignal:<signame> [<type> <value>]"` */
static Signal signals[] = {
	/* signum           function */
	{ "focusstack",     focusstack },
	{ "setmfact",       setmfact },
	{ "togglebar",      togglebar },
	{ "incnmaster",     incnmaster },
	{ "togglefloating", togglefloating },
	{ "focusmon",       focusmon },
	{ "tagmon",         tagmon },
	{ "zoom",           zoom },
	{ "view",           view },
	{ "viewall",        viewall },
	{ "viewex",         viewex },
	{ "toggleview",     view },
	{ "toggleviewex",   toggleviewex },
	{ "tag",            tag },
	{ "tagall",         tagall },
	{ "tagex",          tagex },
	{ "toggletag",      tag },
	{ "toggletagex",    toggletagex },
	{ "killclient",     killclient },
	{ "quit",           quit },
	{ "setlayout",      setlayout },
	{ "setlayoutex",    setlayoutex },
};
// clang-format on
