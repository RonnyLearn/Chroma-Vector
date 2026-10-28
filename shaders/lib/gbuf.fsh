// Shared fragment stage: flat per-surface colour + world normal, the edge pass works on these
uniform sampler2D gtexture;
uniform float alphaTestRef;

in vec2 texUV;
in vec2 tileUV;
in vec3 tint;
in vec3 worldNormal;

/* RENDERTARGETS: 0,3 */
void main() {
#ifdef PASS_DISCARD
	discard;
#endif
#ifdef PASS_SKY
	gl_FragData[0] = vec4(vec3(0.35), 1.0);
	gl_FragData[1] = vec4(0.5, 1.0, 0.5, 1.0);
#else
	if (texture(gtexture, texUV).a < alphaTestRef) discard;
#ifdef PASS_FLAT
	// entities, held items, armour: no stable tile colour, outline by shape only
	vec3 flat_ = vec3(0.5);
#else
	// a deep mip at the tile centre = one average colour per block face
	vec3 flat_ = textureLod(gtexture, tileUV, 4.0).rgb * tint;
#endif
	gl_FragData[0] = vec4(flat_, 1.0);
	gl_FragData[1] = vec4(normalize(worldNormal) * 0.5 + 0.5, 1.0);
#endif
}
