shader_type spatial;
render_mode cull_disabled;

uniform sampler2D noise;

const vec3 base_color = vec3(0.1, 0.12, 0.1);
const vec3 reflection_color = vec3(0.1, 0.12, 0.1);
const float alpha = 0.15;
const float reflection_strength = 0.5;
const float min_alpha_distance = -7.0;
const float max_alpha_distance = 7.0;
const float dirtiness_factor = 0.5;

void fragment() {
	float fresnel = clamp(1.2 - abs(dot(NORMAL, VIEW)), 0.0, 1.0);
	vec3 reflected_light = reflection_color * reflection_strength * fresnel;

	float noise_value = texture(noise, UV).r;

	vec3 albedo = base_color;
	albedo = mix(albedo, albedo * noise_value, dirtiness_factor);
	albedo = mix(albedo, reflected_light, fresnel);

	ALBEDO = albedo;

	float distance_to_camera = length(CAMERA_POSITION_WORLD - NODE_POSITION_WORLD);
	float dist_alpha = clamp((distance_to_camera - min_alpha_distance) / (max_alpha_distance - min_alpha_distance), 0.2, 1.0);

	ALPHA = min(0.95, alpha + (1.0 - alpha) * mix(dist_alpha, fresnel, 0.5 + 0.5 * fresnel - 0.5 * dist_alpha) * (1.0 - noise_value));
}
