shader_type canvas_item;

uniform vec3 color = vec3(0.35, 0.48, 0.95);
uniform float xscale;
uniform float yscale;

void vertex() {
	vec2 coord = VERTEX;
	float rip = coord.y + sin((coord.x *1.3)+ TIME) * (1.0-coord.y);
	rip += sin((coord.x *1.2) - TIME*0.7) * (1.0-coord.y);
	clamp(rip,0.0,VERTEX.y+3.0);
	VERTEX = vec2(coord.x, rip);
}
