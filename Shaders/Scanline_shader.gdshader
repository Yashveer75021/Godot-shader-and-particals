shader_type canvas_item;

// --- Settings ---
uniform float scanline_count : hint_range(0.0, 2000.0) = 50.0;
uniform float scroll_speed : hint_range(-5.0, 5.0) = 0.0; // Set to 0.0 for static lines
uniform float opacity : hint_range(0.0, 1.0) = 0.5; // 0 = No effect, 1 = Full black lines

void fragment() {
    // 1. Get the original color of the sprite/texture
    vec4 color = texture(TEXTURE, UV);
    
    // 2. Calculate the Scanline Math
    // We use a sine wave based on the Y position (UV.y)
    // PI * 2.0 ensures the wave completes full cycles
    float scanline = sin((UV.y * scanline_count * 3.14159 * 2.0) + (TIME * scroll_speed));
    
    // 3. Normalize the scanline (Math cleanup)
    // Sine waves go from -1 to 1. We change this to range 0.0 to 1.0
    scanline = (scanline + 1.0) / 2.0;
    
    // 4. Apply the darkening effect
    // We mix the original color with a darkened version based on the scanline pattern
    // If the scanline value is low, we darken the pixel.
    vec3 darkened_color = color.rgb * scanline;
    
    // Mix between original and darkened based on user "opacity" setting
    color.rgb = mix(color.rgb, darkened_color, opacity);
    
    // Output the final result
    COLOR = color;
}