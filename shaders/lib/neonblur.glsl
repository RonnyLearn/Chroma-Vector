// One direction of the neon halo blur; runs at half resolution, x then y
vec3 neonBlur(sampler2D tex, vec2 p, vec2 dir) {
	vec3 sum = vec3(0.0);
	float wsum = 0.0;
	for (int i = -6; i <= 6; i++) {
		float x = float(i);
		float w = exp(-x * x / 14.0);
		sum += texture(tex, p + dir * x * NEON_SIZE * 2.0 * PX).rgb * w;
		wsum += w;
	}
	return sum / wsum;
}
