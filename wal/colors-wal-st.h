const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#090b0f", /* black   */
  [1] = "#916D58", /* red     */
  [2] = "#C97B55", /* green   */
  [3] = "#D1A06A", /* yellow  */
  [4] = "#7E7B83", /* blue    */
  [5] = "#A69891", /* magenta */
  [6] = "#CBB6A3", /* cyan    */
  [7] = "#ebe1ce", /* white   */

  /* 8 bright colors */
  [8]  = "#a49d90",  /* black   */
  [9]  = "#916D58",  /* red     */
  [10] = "#C97B55", /* green   */
  [11] = "#D1A06A", /* yellow  */
  [12] = "#7E7B83", /* blue    */
  [13] = "#A69891", /* magenta */
  [14] = "#CBB6A3", /* cyan    */
  [15] = "#ebe1ce", /* white   */

  /* special colors */
  [256] = "#090b0f", /* background */
  [257] = "#ebe1ce", /* foreground */
  [258] = "#ebe1ce",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
