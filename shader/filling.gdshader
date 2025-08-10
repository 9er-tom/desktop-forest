shader_type canvas_item;

uniform float progress: hint_range(0.0, 1.0) = 0.;
 
void fragment() {
	vec4 color = texture(TEXTURE, UV);
	color.rgb = mix(color.rgb, vec3(0,0,0).rgb, 0.5);
	if (UV.y < 1. - progress) {
		COLOR = color;
	}
}
