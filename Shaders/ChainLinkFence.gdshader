shader_type spatial;
render_mode cull_disabled;
uniform vec4 albedo : source_color;
uniform sampler2D texture_albedo : source_color,filter_linear_mipmap,repeat_enable;

uniform bool use_draw_range;
uniform float draw_range_start: hint_range(0.0, 1.0, 0.01);
uniform float draw_range_end: hint_range(0.0, 1.0, 0.01);

void fragment() {
	vec2 base_uv = UV;
	vec4 albedo_tex = texture(texture_albedo,base_uv);
	albedo_tex *= COLOR;

	// calculate intensity (brightness) of the color
	float intensity = dot(albedo_tex.rgb, vec3(0.299, 0.587, 0.114)); // weighted sum based on human perception

	// Desaturate light colors
	vec3 grayColor = vec3(0.3); // Change this to desired gray color
	vec3 color = mix(albedo_tex.rgb, grayColor, intensity);

	ALBEDO = albedo.rgb * color;

	if(use_draw_range) {
		if(UV.y >= draw_range_start && UV.y <= draw_range_end) {
			ALPHA = albedo_tex.a;
		}
		else {
			ALPHA = 0.0;
		}
	}
	else {
		ALPHA = albedo_tex.a;
	}

	// more metallic if it's light (intensity closer to 1), less metallic if it's dark (intensity closer to 0)
	METALLIC = intensity * intensity;

	// more rough if it's dark (intensity closer to 0), less rough if it's light (intensity closer to 1)
	ROUGHNESS = 1.0 - intensity;
}
