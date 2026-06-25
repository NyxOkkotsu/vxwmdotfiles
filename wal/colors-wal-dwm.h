static const char norm_fg[] = "#ebe1ce";
static const char norm_bg[] = "#090b0f";
static const char norm_border[] = "#a49d90";

static const char sel_fg[] = "#ebe1ce";
static const char sel_bg[] = "#C97B55";
static const char sel_border[] = "#ebe1ce";

static const char urg_fg[] = "#ebe1ce";
static const char urg_bg[] = "#916D58";
static const char urg_border[] = "#916D58";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
