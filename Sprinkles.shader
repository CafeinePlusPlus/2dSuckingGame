shader_type canvas_item;

uniform vec3 color = vec3(0.0,1.0,1.0);


vec4 drawA(vec2 coord){
	vec2 pos = floor(mod(coord, vec2(30.0)));
	if(pos.y >= 10.0|| pos.x >= 10.0){
		return vec4(color,0.0);
	}
	vec2 bigsq = floor(pos/vec2(3.0));
	if(bigsq==vec2(1.0)){
		return vec4(color, 0.07);
	}
	if(pos.x == 2.0 && (pos.y == 4.0 || pos.y == 6.0 || pos.y == 7.0)){
		return vec4(color,0.1);
	}
	if(pos.y == 6.0 && (pos.x == 4.0 || pos.x == 1.0)){
		return vec4(color,0.1);
	}
	return vec4(color, 0.0);
}
vec4 drawB(vec2 coord){
	vec2 pos = floor(mod(coord, vec2(30.0)));
	if(pos.y >= 10.0|| pos.x >= 10.0){
		return vec4(color,0.0);
	}
	vec2 bigsq = floor(pos/vec2(2.0));
	if(bigsq==vec2(1.0)){
		return vec4(color, 0.05);
	}
	if(pos.x == 1.0 && (pos.y == 2.0 || pos.y == 4.0 || pos.y == 6.0)){
		return vec4(color,0.05);
	}
	if(pos.y == 6.0 && (pos.x == 5.0 || pos.x == 1.0)){
		return vec4(color,0.04);
	}
	return vec4(color, 0.0);
}

void fragment(){
	vec2 grid = vec2(UV.x*8.0,UV.y*6.0);
	vec2 coord = (grid+ vec2(-TIME*0.3,-TIME*0.1))*30.0;
	vec2 whole = floor(floor(grid)*vec2(4.0/8.0,1.0));
	if(mod(whole.y,2.0) == 0.0 && (whole.x == 1.0 || whole.x == 3.0)){
		COLOR = drawA(coord);
	}
	else if(mod(whole.y,2.0) == 1.0 && (whole.x == 0.0 || whole.x == 2.0)){
		COLOR = drawA(coord);
	}
	else if(mod(whole.y,2.0) == 0.0 && (whole.x == 0.0 || whole.x == 2.0)){
		COLOR = drawB(coord);
	}
	else if(mod(whole.y,2.0) == 1.0 && (whole.x == 1.0 || whole.x == 3.0)){
		COLOR = drawB(coord);
	}
	
}
