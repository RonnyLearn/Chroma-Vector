#version 150 compatibility
// Pass 2: thicken lines, colour them with the rainbow, add glow and afterglow
#include "/lib/config.glsl"
#include "/lib/rainbow.glsl"

uniform sampler2D colortex1;
uniform sampler2D colortex2;
uniform float far;
uniform float frameTime;
uniform mat4 gbufferModelView;
uniform mat4 gbufferPreviousModelView;
uniform vec3 cameraPosition;
uniform vec3 previousCameraPosition;
const bool colortex2Clear = false;
in vec2 uv;

float lineAt(vec2 p) {
	float m = texture(colortex1, p).r;
	for (int r = 1; r <= LINE_THICKNESS; r++) {
		m = max(m, texture(colortex1, p + vec2(r, 0) * PX).r);
		m = max(m, texture(colortex1, p + vec2(0, r) * PX).r);
	}
	return m;
}

/* RENDERTARGETS: 0,2 */
void main() {
	float line = lineAt(uv);

	float glow = 0.0;
#ifndef NEON_GLOW
	if (GLOW > 0.0) {
		for (int i = 0; i < 8; i++) {
			float a = float(i) * 0.785398;
			glow += texture(colortex1, uv + vec2(cos(a), sin(a)) * GLOW_RADIUS * PX).r;
		}
		glow *= GLOW / 8.0;
	}
#endif

	vec3 col = lineColor(uv, texture(colortex1, uv).g * far) * min(line + glow, 1.5);

	vec3 prev = texture(colortex2, uv).rgb;
	// the old frame is not reprojected, so any camera turn or step would leave
	// trails that blink out; keep the afterglow only while the view is still
	float turn = distance(gbufferModelView[2].xyz, gbufferPreviousModelView[2].xyz)
	           + distance(gbufferModelView[0].xyz, gbufferPreviousModelView[0].xyz);
	float step_ = distance(cameraPosition, previousCameraPosition);
	float still = 1.0 - smoothstep(0.0005, 0.004, turn + step_ * 0.05);
	float keep = pow(AFTERGLOW, frameTime * 60.0) * still;
	vec3 trail = max(col, prev * keep);

	gl_FragData[0] = vec4(trail, 1.0);
	gl_FragData[1] = vec4(trail, 1.0);
}
