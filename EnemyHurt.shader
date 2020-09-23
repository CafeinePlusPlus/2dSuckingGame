shader_type canvas_item;


uniform vec3 color = vec3(0.35, 0.48, 0.95);

float rand(vec2 coord) {
	return fract(dot(coord,vec2(14,56)));
}

void fragment() {
	vec2 coord = UV * 20.0;
	
	COLOR = vec4(color, 1);
}
