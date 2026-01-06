shader_type canvas_item;

// --- Uniforms (Settings you see in the Inspector) ---
uniform float scanline_count : hint_range(0.0, 2000.0) = 50.0;
uniform float scroll_speed : hint_range(-5.0, 5.0) = 0.0; // Set to 0.0 for static lines
uniform float opacity : hint_range(0.0, 1.0) = 0.5; // 0 = No effect, 1 = Full black lines

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    float scanline = sin((UV.y * scanline_count * 3.14159 * 2.0) + (TIME * scroll_speed));
    scanline = (scanline + 1.0) / 2.0;
    vec3 darkened_color = color.rgb * scanline;
    color.rgb = mix(color.rgb, darkened_color, opacity);
    
    COLOR = color;
}