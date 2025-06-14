/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 4;        /* border pixel of windows */
static const unsigned int snap      = 0;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const int focusonwheel       = 0;
static const char statussep         = ';';      /* separator between status bars */
static const char *fonts[]          = { "ComicCode Nerd Font Mono:size=11" };
static const char dmenufont[]       = "ComicCode Nerd Font Mono:size=11";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#005577";
static const unsigned int baralpha = 0x80;
static const unsigned int borderalpha = OPAQUE;
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
	[SchemeHid]  = { col_cyan,  col_gray1, col_gray1  },
};
static const unsigned int alphas[][3]      = {
    /*               fg      bg        border*/
    [SchemeNorm] = { OPAQUE, baralpha, borderalpha },
	  [SchemeSel]  = { OPAQUE, baralpha, borderalpha },
    [SchemeHid]  = { OPAQUE, baralpha, borderalpha },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
	{ "Firefox",  NULL,       NULL,       1 << 8,       0,           -1 },
};

/* Bar rules allow you to configure what is shown where on the bar, as well as
 * introducing your own bar modules.
 *
 *    monitor:
 *      -1  show on all monitors
 *       0  show on monitor 0
 *      'A' show on active monitor (i.e. focused / selected) (or just -1 for active?)
 *    bar - bar index, 0 is default, 1 is extrabar
 *    alignment - how the module is aligned compared to other modules
 *    widthfunc, drawfunc, clickfunc - providing bar module width, draw and click functions
 *    name - does nothing, intended for visual clue and for logging / debugging
 */
static const BarRule barrules[] = {
	/* monitor  bar    alignment         widthfunc              drawfunc              clickfunc           name */
	{ -1,       0,     BAR_ALIGN_LEFT,   width_tags,            draw_tags,            click_tags,         "tags" },
	{ -1,       0,     BAR_ALIGN_LEFT,   width_ltsymbol,        draw_ltsymbol,        click_ltsymbol,     "layout" },
	{ -1,       0,     BAR_ALIGN_RIGHT,  width_status2d,        draw_status2d,        click_statuscmd,    "status2d" },
	{ -1,       0,     BAR_ALIGN_NONE,   width_awesomebar,      draw_awesomebar,      click_awesomebar,   "awesomebar" },
	{  0,       0,     BAR_ALIGN_CENTER, width_status2d_es,     draw_status2d_es,     click_statuscmd_es, "status2d_es" },

};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
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
#define AltMask Mod1Mask
#define ALLMASK MODKEY|AltMask|ControlMask|ShiftMask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|AltMask,               KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|AltMask|ShiftMask,     KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run","-l", "20", "-vi", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]  = { "kitty", "--title", "Terminal", NULL };

#include "movestack.c"
static const Key keys[] = {
	/* modifier                     key        function        argument */
	/* modifier                     key        function        argument */
  // { Mod1Mask|MODKEY,         XK_1,      spawn,          SHCMD("changebg") },
  // { Mod1Mask|MODKEY,         XK_2,      spawn,          SHCMD("bgswap.sh") },
  // { Mod1Mask|MODKEY,         XK_3,      spawn,          SHCMD("dmenuEmoji.sh") },
  // { Mod1Mask|MODKEY,         XK_4,      spawn,          SHCMD("screenshot.sh --select") },
  // { Mod1Mask|MODKEY,         XK_5,      spawn,          SHCMD("screenshot.sh --blur") },
  // { Mod1Mask|MODKEY,         XK_6,      spawn,          SHCMD("screenshot.sh --hide") },
  // { Mod1Mask|MODKEY,         XK_7,      spawn,          SHCMD("screenshot.sh --full") },
  // { Mod1Mask|MODKEY,         XK_8,      spawn,          SHCMD("screenshot.sh --wiki") },
  // { Mod1Mask|MODKEY,         XK_g,      spawn,          SHCMD("screenshot.sh --pictures") },
  { MODKEY|AltMask,               XK_b,      spawn,          SHCMD("firefox") },
  { MODKEY|AltMask,               XK_s,      spawn,          SHCMD("steam") },
  { MODKEY|AltMask,               XK_d,      spawn,          SHCMD("discord") },
  { MODKEY|AltMask,               XK_p,      spawn,          SHCMD("pavucontrol") },
  // { Mod1Mask|MODKEY,         XK_i,      spawn,          SHCMD("Audio_Swap.sh") },
  // { ShiftMask|MODKEY,         XK_t,      spawn,          SHCMD("OCR_scrot.sh") },
  { MODKEY|AltMask,               XK_c,      spawn,          SHCMD("colorpicker.sh") },//
  // { ShiftMask|MODKEY,         XK_s,      spawn,          SHCMD("screen_to_clipboard.sh") },
  // { MODKEY,                       XK_Insert, spawn,          SHCMD("xdotool type $(grep -v '^#' ~/ssd/Documents/snippets | dmenu -i -l 50 | cut -d' ' -f1)") },
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_m,      spawn,          {.v = termcmd } },
	{ MODKEY|ShiftMask,             XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_o,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_u,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_y,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_h,      focusmon,       {.i = +1} },
	{ MODKEY,                       XK_l,      focusmon,       {.i = -1} },
	{ MODKEY|ShiftMask,             XK_h,      tagmon,         {.i = +1} },
	{ MODKEY|ShiftMask,             XK_l,      tagmon,         {.i = -1} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_j,      movestack,      {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_k,      movestack,      {.i = -1 } },
	{ MODKEY,                       XK_z,      zoom,           {0} },
	{ MODKEY|ShiftMask,             XK_Tab,    showhideclient, {0} },
	{ MODKEY,                       XK_r,      viewnext,       {0} },
	{ MODKEY,                       XK_c,      viewprev,       {0} },
	{ MODKEY|ShiftMask,             XK_r,	     tagtonext,      {0} },
	{ MODKEY|ShiftMask,             XK_c,	     tagtoprev,      {0} },
	{ MODKEY,                       XK_q,      killclient,     {0} },
	{ MODKEY,                       XK_d,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_b,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  togglefloating, {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
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
	{ ALLMASK,                      XK_q,        quit,        {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button1,        togglewin,      {0} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkWinTitle,          0,              Button3,        showhideclient, {0} },
	{ ClkStatusText,        0,              Button1,        sigdwmblocks,   {.i = 1 } },
	{ ClkStatusText,        0,              Button2,        sigdwmblocks,   {.i = 2 } },
	{ ClkStatusText,        0,              Button3,        sigdwmblocks,   {.i = 3 } },
	{ ClkStatusText,        0,              Button4,        sigdwmblocks,   {.i = 4 } },
	{ ClkStatusText,        0,              Button5,        sigdwmblocks,   {.i = 5 } },
	{ ClkClientWin,       ShiftMask,        Button1,        movemouse,      {0} },
	{ ClkClientWin,       ShiftMask,        Button2,        togglefloating, {0} },
	{ ClkClientWin,         AltMask,        Button3,        resizeorfacts,  {0} },
	{ ClkClientWin,       ShiftMask,        Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            AltMask,        Button3,        toggleview,     {0} },
	{ ClkTagBar,          ShiftMask,        Button1,        tag,            {0} },
	{ ClkTagBar,  AltMask|ShiftMask,        Button3,        toggletag,      {0} },
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
