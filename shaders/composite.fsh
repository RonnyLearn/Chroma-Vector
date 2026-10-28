#version 150 compatibility
// Pass 1: find edges from flat colour, depth and normals -> line mask
#include "/lib/config.glsl"

uniform sampler2D colortex0;
uniform sampler2D colortex3;
uniform sampler2D depthtex0;
uniform float near;
uniform float far;
in vec2 uv;

float linDepth(vec2 p) {
	float z = texture(depthtex0, p).r * 2.0 - 1.0;
	return 2.0 * near * far / (far + near - z * (far - near));
}

// soft threshold so lines fade in instead of popping on and off
float over(float v, float th) { return smoothstep(th, th * 1.6, v); }

/*
const int colortex1Format = RG16;
const int colortex4Format = R11F_G11F_B10F;
const int colortex5Format = R11F_G11F_B10F;
*/

/* RENDERTARGETS: 1 */
void main() {
	vec3  c0 = texture(colortex0, uv).rgb;
	vec3  n0 = texture(colortex3, uv).rgb * 2.0 - 1.0;
	float z0 = linDepth(uv);

	vec2 dx = vec2(PX.x, 0.0), dy = vec2(0.0, PX.y);
	float zl = linDepth(uv - dx), zr = linDepth(uv + dx);
	float zd = linDepth(uv - dy), zu = linDepth(uv + dy);

	// 1/z is exactly linear across any plane on screen, so its curvature is zero on flat
	// surfaces however steep; it is positive only on the near side of a silhouette
	float w0 = 1.0 / z0;
	float bulge = w0 - min(1.0 / zl + 1.0 / zr, 1.0 / zu + 1.0 / zd) * 0.5;
	float edge = over(bulge / w0, EDGE_DEPTH);

	vec2 dirs[4] = vec2[](dx, -dx, dy, -dy);
	float zs[4] = float[](zr, zl, zu, zd);
	for (int i = 0; i < 4; i++) {
		if (z0 > zs[i] + z0 * 0.002) continue;   // the nearer side draws the line
		vec2 q = uv + dirs[i];
		vec3 n = texture(colortex3, q).rgb * 2.0 - 1.0;
		vec3 c = texture(colortex0, q).rgb;
		edge = max(edge, over(1.0 - dot(n0, n), EDGE_NORMAL));
		edge = max(edge, over(distance(c0, c), EDGE_COLOR));
	}

	// far lines get dense and shimmer, fade them out
	edge *= 1.0 - smoothstep(LINE_FADE, LINE_FADE * 1.6, z0);

	gl_FragData[0] = vec4(edge, z0 / far, 0.0, 1.0);
}
