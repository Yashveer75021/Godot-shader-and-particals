shader_type canvas_item;

// --- Uniforms (Settings you see in the Inspector) ---
uniform vec4 line_color : source_color = vec4(1.0, 1.0, 1.0, 1.0); // White outline by default
uniform float line_thickness : hint_range(0.0, 10.0) = 1.0; // How thick the line is in pixels

void fragment() {
    vec2 size = TEXTURE_PIXEL_SIZE * line_thickness;
    float outline = texture(TEXTURE, UV + vec2(-size.x, 0)).a;   // Left
    outline += texture(TEXTURE, UV + vec2(0, size.y)).a;         // Down
    outline += texture(TEXTURE, UV + vec2(size.x, 0)).a;         // Right
    outline += texture(TEXTURE, UV + vec2(0, -size.y)).a;        // Up
    outline += texture(TEXTURE, UV + vec2(-size.x, -size.y)).a;  // Top-Left
    outline += texture(TEXTURE, UV + vec2(size.x, size.y)).a;    // Bottom-Right
    outline += texture(TEXTURE, UV + vec2(-size.x, size.y)).a;   // Bottom-Left
    outline += texture(TEXTURE, UV + vec2(size.x, -size.y)).a;   // Top-Right

    // Clamp the result so it doesn't exceed 1.0
    outline = min(outline, 1.0);

    // Get the actual color of the sprite at this pixel
    vec4 original_color = texture(TEXTURE, UV);

    // Logic:
    // If 'outline' is 1 (neighbors exist) AND 'original_color.a' is 0 (current pixel is empty),
    // The result of (outline - original_color.a) is 1. We show the line_color.
    // Otherwise, we show the original_color.
    COLOR = mix(original_color, line_color, outline - original_color.a);
}