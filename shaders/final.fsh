#version 150 compatibility
// Final: neon mix, screen curvature, background tint, scanlines
#include "/lib/config.glsl"
#include "/lib/rainbow.glsl"

uniform sampler2D colortex0;
uniform sampler2D colortex5;
in vec2 uv;

void main() {
	vec2 p = uv * 2.0 - 1.0;
	// scaled so the corners land exactly on the screen edge: no black borders
	float k = CRT_CURVE * 0.15;
	p *= (1.0 + k * dot(p, p)) / (1.0 + 2.0 * k);
	vec2 q = p * 0.5 + 0.5;

	vec3 col = texture(colortex0, q).rgb;

#ifdef NEON_GLOW
	float peak = max(col.r, max(col.g, col.b));
	col = mix(col, vec3(peak), NEON_CORE * 0.6 * smoothstep(0.6, 1.0, peak)) * (1.0 + NEON_CORE * 0.3);
	vec3 halo = texture(colortex5, q).rgb;
	float hum = 1.0 - NEON_FLICKER * (0.5 + 0.5 * sin(frameTimeCounter * 37.0) * sin(frameTimeCounter * 5.3));
	col = (col + halo * NEON_STRENGTH * 1.1) * hum;
	col = 1.0 - exp(-col * 1.2);
#endif
	col += lineColor(q, 0.0) * BACKGROUND;

	float y = q.y * viewHeight;
	col *= 1.0 - SCANLINES * step(2.0, mod(y, 3.0));
	float band = fract(q.y + frameTimeCounter * 0.15);
	col *= 1.0 + SCAN_BAND * smoothstep(0.03, 0.0, abs(band - 0.5));

	gl_FragColor = vec4(col, 1.0);
}
