shader_type spatial;

render_mode cull_disabled;

uniform vec3 base_color = vec3(0.6, 0.6, 1.0);
uniform vec3 reflection_color = vec3(0.05, 0.05, 0.1);
uniform float alpha : hint_range(0, 1) = 0.25;
uniform float fresnel_power : hint_range(0.1, 5.0) = 1.5;
uniform float reflection_strength : hint_range(0, 1) = 0.5;

void fragment() {
	vec3 albedo = base_color;
	float fresnel = pow(clamp(1.0 - abs(dot(NORMAL, VIEW)), 0.2, 0.8), fresnel_power);
	vec3 reflected_light = reflection_color * reflection_strength * fresnel;

	albedo = mix(albedo, reflected_light, fresnel);

	ALBEDO = albedo;
	ALPHA = alpha * fresnel;
}
