#version 150 compatibility
// Pass 3: neon halo, horizontal
#include "/lib/config.glsl"
#include "/lib/neonblur.glsl"

uniform sampler2D colortex0;
in vec2 uv;

/* RENDERTARGETS: 4 */
void main() {
#ifdef NEON_GLOW
	gl_FragData[0] = vec4(neonBlur(colortex0, uv, vec2(1.0, 0.0)), 1.0);
#else
	gl_FragData[0] = vec4(0.0);
#endif
}
