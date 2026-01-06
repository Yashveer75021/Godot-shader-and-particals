shader_type canvas_item;

// --- Uniforms (Settings you see in the Inspector) ---
uniform sampler2D noise_texture; // The dissolve pattern
uniform float dissolve_value : hint_range(0.0, 1.0) = 1.0; // 0 = invisible, 1 = visible
uniform vec4 burn_color : source_color = vec4(1.0, 0.5, 0.0, 1.0); // Orange glow
uniform float burn_size : hint_range(0.0, 0.1) = 0.05; // Thickness of the edge

void fragment() {
    // 1. Get the current pixel color of the Sprite
    vec4 main_color = texture(TEXTURE, UV);
    
    // 2. Get the noise value at this pixel (using red channel)
    float noise = texture(noise_texture, UV).r;
    
    // 3. Calculate Visibility (The Cutout)
    // If noise is lower than dissolve_value, it disappears.
    float is_visible = step(1.0 - dissolve_value, noise); 
    
    // 4. Calculate the Burn Edge
    // We make a second, slightly wider mask to find the edge
    float edge_mask = step(1.0 - dissolve_value - burn_size, noise);
    // The "edge" is the difference between the wider mask and the visible mask
    vec4 burn = (edge_mask - is_visible) * burn_color;
    
    // 5. Apply Results
    // Set the final color (Original Sprite + Glow)
    COLOR = main_color + burn;
    
    // Set the Alpha (transparency)
    // We multiply original alpha by our visibility mask so it fades out
    COLOR.a = main_color.a * edge_mask;
}