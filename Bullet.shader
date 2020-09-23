shader_type canvas_item;


uniform vec3 color = vec3(0.35, 0.48, 0.95);
uniform int OCTAVES = 4;
uniform vec2 center = vec2(0.5,0.8);

float rand(vec2 coord){
	return fract((sin(dot(coord, vec2(28, 85)))/(cos(dot(coord, vec2(47, 34))) + 0.2) * 1000.0) * 1000.0);
}

float noise(vec2 coord){
	vec2 i = floor(coord);
	vec2 f = fract(coord);

	// 4 corners of a rectangle surrounding our point
	float a = rand(i);
	float b = rand(i + vec2(1.0, 0.0));
	float c = rand(i + vec2(0.0, 1.0));
	float d = rand(i + vec2(1.0, 1.0));

	vec2 cubic = f * f * (3.0 - 2.0 * f);

	return mix(a, b, cubic.x) + (c - a) * cubic.y * (1.0 - cubic.x) + (d - b) * cubic.x * cubic.y;
}

float fbm(vec2 coord){
	float value = 0.0;
	float scale = 0.5;

	for(int i = 0; i < OCTAVES; i++){
		value += noise(coord) * scale;
		coord *= 2.0;
		scale *= 0.5;
	}
	return value;
}
float egg_shape(vec2 coord, float radius){
	vec2 diff = abs(coord - center);

	if (coord.y < center.y){
		diff.y /= 2.0;
	} else {
		diff.y *= 2.0;
	}

	float dist = sqrt(diff.x * diff.x + diff.y * diff.y) / radius;
	float value = sqrt(1.0 - dist * dist);
	return clamp(value, 0.0, 1.0);
}

void fragment() {
	vec2 coord = UV * 20.0;
	float egg_s = egg_shape(UV, 0.4);
	egg_s += egg_shape(UV, 0.2) / 2.0;

	vec2 motion = vec2( fbm(coord + vec2(TIME * -3.0, TIME * 3.0)) );

	float final = fbm(coord + motion) * egg_s;

	COLOR = vec4(color, final);
}
