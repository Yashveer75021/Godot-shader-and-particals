shader_type canvas_item;

uniform sampler2D noise_texture : repeat_enable;
uniform float speed = 2.0; 
uniform vec4 wind_color : source_color = vec4(0.8, 0.9, 1.0, 1.0);
uniform float density = 0.5; 

void fragment() {
    vec2 moving_uv = vec2(UV.x - (TIME * speed), UV.y);
    float noise_value = texture(noise_texture, moving_uv).r;
    float side_mask = 1.0 - abs(UV.y - 0.5) * 2.0; // Top/Bottom fade
    float end_mask = sin(UV.x * 3.14159); // Left/Right fade
    float lines = step(density, noise_value * side_mask * end_mask);
   
    COLOR = wind_color;
    COLOR.a = lines * wind_color.a;
}