uniform float viewWidth;
uniform float viewHeight;
uniform float frameTimeCounter;
#define PX (1.0 / vec2(viewWidth, viewHeight))

// ---- Rainbow ----
#define RAINBOW
#define RGB_SPEED 0.1 // [-2.0 -1.5 -1.0 -0.7 -0.5 -0.3 -0.2 -0.1 0.0 0.05 0.1 0.2 0.3 0.5 0.7 1.0 1.5 2.0 3.0 5.0]
#define RGB_HUE_START 0 // [0 15 30 45 60 75 90 105 120 135 150 165 180 195 210 225 240 255 270 285 300 315 330 345]
#define RGB_HUE_RANGE 360 // [0 30 45 60 90 120 150 180 210 240 270 300 330 360]
#define RGB_SATURATION 0.8 // [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]
#define RGB_BRIGHTNESS 0.8 // [0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.2 1.5 2.0]
#define RGB_PATTERN 0 // [0 1 2 3 4]
#define RGB_SCALE 0.5 // [0.1 0.25 0.5 0.75 1.0 1.5 2.0 3.0 4.0 6.0 8.0]
#define SOLID_R 0.0 // [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]
#define SOLID_G 1.0 // [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]
#define SOLID_B 0.3 // [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]

// ---- Lines ----
#define EDGE_COLOR 0.12 // [0.0 0.04 0.06 0.08 0.1 0.12 0.15 0.2 0.3 0.5 1.0 100.0]
#define EDGE_DEPTH 0.02 // [0.005 0.01 0.015 0.02 0.03 0.04 0.06 0.08 0.1 100.0]
#define EDGE_NORMAL 0.25 // [0.05 0.1 0.15 0.2 0.25 0.3 0.4 0.5 0.7 100.0]
#define LINE_THICKNESS 1 // [0 1 2 3]
#define LINE_FADE 96.0 // [32.0 48.0 64.0 96.0 128.0 192.0 256.0 512.0 10000.0]

// ---- Screen ----
#define GLOW 0.4 // [0.0 0.2 0.4 0.6 0.8 1.0 1.5 2.0]
#define GLOW_RADIUS 3.0 // [1.0 2.0 3.0 4.0 6.0 8.0]
#define AFTERGLOW 0.0 // [0.0 0.2 0.4 0.5 0.6 0.7 0.8 0.9]
#define CRT_CURVE 0.2 // [0.0 0.2 0.4 0.6 0.8 1.0 1.5]
#define BACKGROUND 0.02 // [0.0 0.01 0.02 0.03 0.05 0.08 0.12]
#define SCANLINES 0.0 // [0.0 0.2 0.4 0.6 0.8 1.0]
#define SCAN_BAND 0.0 // [0.0 0.5 1.0 2.0]

// ---- Neon ----
// #define NEON_GLOW
#define NEON_STRENGTH 1.0 // [0.5 0.75 1.0 1.25 1.5 2.0 2.5 3.0 4.0]
#define NEON_SIZE 2.0 // [1.0 1.5 2.0 3.0 4.0 6.0]
#define NEON_CORE 0.4 // [0.0 0.2 0.4 0.6 0.8 1.0]
#define NEON_SHAPE 0 // [0 1 2]
#define NEON_FLICKER 0.0 // [0.0 0.05 0.1 0.2 0.3]
