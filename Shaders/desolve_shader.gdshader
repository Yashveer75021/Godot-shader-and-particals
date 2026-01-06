shader_type canvas_item;

// --- Uniforms (Settings you see in the Inspector) ---
uniform sampler2D noise_texture; // The dissolve pattern
uniform float dissolve_value : hint_range(0.0, 1.0) = 1.0; // 0 = invisible, 1 = visible
uniform vec4 burn_color : source_color = vec4(1.0, 0.5, 0.0, 1.0); // Orange glow
uniform float burn_size : hint_range(0.0, 0.1) = 0.05; // Thickness of the edge

void fragment() {
    vec4 main_color = texture(TEXTURE, UV); 
    float noise = texture(noise_texture, UV).r;
    float is_visible = step(1.0 - dissolve_value, noise); 
    float edge_mask = step(1.0 - dissolve_value - burn_size, noise);
    vec4 burn = (edge_mask - is_visible) * burn_color;
   
    // Set the final color (Original Sprite + Glow)
    COLOR = main_color + burn;
    COLOR.a = main_color.a * edge_mask;
}