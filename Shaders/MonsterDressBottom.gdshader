shader_type spatial;

uniform sampler2D img;

void fragment() {
	vec4 color = texture(img, UV.xy);
	ALBEDO = color.rgb;
	ALPHA = color.a * 2.0;
}
