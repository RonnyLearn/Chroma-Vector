// Shared vertex stage for every gbuffers program
in vec2 mc_midTexCoord;
uniform mat4 gbufferModelViewInverse;

out vec2 texUV;
out vec2 tileUV;
out vec3 tint;
out vec3 worldNormal;

void main() {
	gl_Position = ftransform();
	texUV  = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	tileUV = (gl_TextureMatrix[0] * vec4(mc_midTexCoord, 0.0, 1.0)).xy;
	tint = gl_Color.rgb;
	worldNormal = mat3(gbufferModelViewInverse) * normalize(gl_NormalMatrix * gl_Normal);
}
