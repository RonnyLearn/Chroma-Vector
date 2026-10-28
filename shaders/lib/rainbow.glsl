#if defined NEON_GLOW && NEON_SHAPE == 1
	#define PATTERN 2
#elif defined NEON_GLOW && NEON_SHAPE == 2
	#define PATTERN 0
#else
	#define PATTERN RGB_PATTERN
#endif

// Cosine rainbow: every channel changes along a smooth wave, so hues blend
// without the hard corners of a classic HSV wheel
vec3 hsv(float h, float s, float v) {
	vec3 k = 0.5 + 0.5 * cos(6.2831853 * (h + vec3(0.0, -1.0, 1.0) / 3.0));
	return v * mix(vec3(1.0), k, s);
}

// Line colour at a screen position; depthLin is linear distance (only used by pattern 3)
vec3 lineColor(vec2 p, float depthLin) {
#ifndef RAINBOW
	return vec3(SOLID_R, SOLID_G, SOLID_B) * RGB_BRIGHTNESS;
#else
	vec2 c = (p - 0.5) * vec2(viewWidth / viewHeight, 1.0);
	float k;
	#if PATTERN == 0    // diagonal sweep
		k = (c.x + c.y) * 0.5;
	#elif PATTERN == 1  // horizontal
		k = c.x * 0.5;
	#elif PATTERN == 2  // rings from centre
		k = length(c);
	#elif PATTERN == 3  // by distance from the camera
		k = depthLin * 0.02;
	#else               // whole screen one colour
		k = 0.0;
	#endif
	float t = fract(k * RGB_SCALE - frameTimeCounter * RGB_SPEED * 0.25);
	float span = RGB_HUE_RANGE >= 360 ? t : 1.0 - abs(t * 2.0 - 1.0);
	float h = (float(RGB_HUE_START) + span * float(RGB_HUE_RANGE)) / 360.0;
	return hsv(h, RGB_SATURATION, RGB_BRIGHTNESS);
#endif
}
