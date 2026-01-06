shader_type canvas_item;
 
// --- Uniforms (Settings you see in the Inspector) ---
uniform vec4 CAST_COLOR : source_color;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;
uniform sampler2D fast_noise : repeat_enable;
uniform vec2 speed = vec2(0.03, 0.07);
uniform float wave_strength = 2;
uniform vec4 shore_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float shore_size : hint_range(0.0, 0.5) = 0.05;
uniform float shore_wiggle : hint_range(0.0, 0.1) = 0.02;
//scale and zoom parameters for when editor changes (set from script)
uniform float scale_y;
uniform float y_zoom;
 
void vertex() {
    //move water up and down
    VERTEX.y += sin(TIME) * 0.01;
}
 
void fragment() {
    //get ripple noise
    vec2 uv = UV + speed * TIME;
    vec2 noise = texture(fast_noise, uv).rg;
    float uv_height = (SCREEN_PIXEL_SIZE.y / TEXTURE_PIXEL_SIZE.y);
    //calc where reflection is coming from
    vec2 reflected_uv = vec2(SCREEN_UV.x, SCREEN_UV.y - (uv_height * UV.y * scale_y * y_zoom));
    //get reflection pixel
    vec4 reflection = texture(SCREEN_TEXTURE, reflected_uv);
    //calc waves for ripples
    vec4 waves = texture(SCREEN_TEXTURE, reflected_uv + noise * y_zoom * (wave_strength / 100.0));
    float threshold = shore_size + (noise.x * shore_wiggle);
    float is_foam = step(UV.y, threshold);
    vec4 water_color = waves + CAST_COLOR;
    //COLOR = mix(water_color, shore_color, is_foam);
	
	// i dont like how the shore look like if you want it make use the commennt the buttom COLOR property 
	//all the thing that use to make shore is avilable so if you want to use make sure to use the  mix(water_color, shore_color, is_foam); in color property 
    //apply wave ripples and selected color
    COLOR =  waves + CAST_COLOR ;
 
}