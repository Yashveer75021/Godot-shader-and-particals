shader_type canvas_item;
 
//add a color picker to inspector
uniform vec4 CAST_COLOR : source_color;
 
//get the underlying screen texture
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;
 
//add a noise resource to inspector (for fast noise)
uniform sampler2D fast_noise : repeat_enable;
 
//speed at which waves move
uniform vec2 speed = vec2(0.03, 0.07);
 
//strength of waves
uniform float wave_strength = 2;

// Color of the foam line (White)
uniform vec4 shore_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);

// How thick the foam line is
uniform float shore_size : hint_range(0.0, 0.5) = 0.05;

// How much the foam wiggles
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
    
    //get the noise from fast noise
    vec2 noise = texture(fast_noise, uv).rg;
 
    //get size of object shader is on
    float uv_height = (SCREEN_PIXEL_SIZE.y / TEXTURE_PIXEL_SIZE.y);
 
    //calc where reflection is coming from
    vec2 reflected_uv = vec2(SCREEN_UV.x, SCREEN_UV.y - (uv_height * UV.y * scale_y * y_zoom));
    
    //get reflection pixel
    vec4 reflection = texture(SCREEN_TEXTURE, reflected_uv);
    //reflect without waves
    //COLOR = reflection + CAST_COLOR
    
    //calc waves for ripples
    vec4 waves = texture(SCREEN_TEXTURE, reflected_uv + noise * y_zoom * (wave_strength / 100.0));
    
	// --- NEW SHORE LOGIC STARTS HERE ---
    
    // 1. Calculate the threshold. 
    // We want the top of the sprite (UV.y = 0) to be foam.
    // We add 'noise.x' so the line isn't straight; it wiggles with the waves.
    float threshold = shore_size + (noise.x * shore_wiggle);
    
    // 2. Determine if this pixel is foam or water.
    // 'step' returns 1.0 if UV.y is smaller than threshold, else 0.0.
    // This creates a hard "Pixel Art" cut.
    float is_foam = step(UV.y, threshold);
    
    // 3. Mix the Water color with the Shore color based on the result.
    vec4 water_color = waves + CAST_COLOR;
    //COLOR = mix(water_color, shore_color, is_foam);
	
	// i dont like how the shore look like if you want it make use the commennt the buttom COLOR property 
	//all the thing that use to make shore is avilable so if you want to use make sure to use the  mix(water_color, shore_color, is_foam); in color property 
    //apply wave ripples and selected color
    COLOR =  waves + CAST_COLOR ;
 
}