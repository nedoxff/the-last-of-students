shader_type canvas_item;
//render_mode blend_add;

uniform bool highlight;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	//COLOR.a = 0.0;
	if(highlight)
	{
		//COLOR.r = 0.5;
		COLOR = vec4(218./255.,165./255.,32./255., texture(TEXTURE, UV).a-0.3);
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
