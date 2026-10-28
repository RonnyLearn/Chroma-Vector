#version 150 compatibility
// Pass 4: neon halo, vertical
#include "/lib/config.glsl"
#include "/lib/neonblur.glsl"

uniform sampler2D colortex4;
in vec2 uv;

/* RENDERTARGETS: 5 */
void main() {
#ifdef NEON_GLOW
	gl_FragData[0] = vec4(neonBlur(colortex4, uv, vec2(0.0, 1.0)), 1.0);
#else
	gl_FragData[0] = vec4(0.0);
#endif
}
