shader_type canvas_item;
render_mode unshaded, skip_vertex_transform;

// --- Uniforms (Settings you see in the Inspector) ---
uniform sampler2D screen_texture: hint_screen_texture, filter_linear_mipmap;

// WARP SETTINGS
// Controls how spherical the screen looks. Higher = flatter, Lower = more curved. most of the time 4 look good.
uniform float curvature : hint_range(0.1, 15.0) = 7.0;

// VIGNETTE SETTINGS
uniform float vignette_multiplier : hint_range(0.0, 5.0) = 2.0;

// Controls how soft/large the vignette is. Higher = softer edges.
uniform float vignette_softness : hint_range(1.0, 10.0) = 3.0;

// SCANLINE SETTINGS
uniform float scan_line_count : hint_range(50.0, 1080.0) = 180.0;
uniform float scan_line_opacity : hint_range(0.0, 1.0) = 0.1;
uniform float scan_line_roll_speed : hint_range(-20.0, 20.0) = 10.0;

// DISPLAY SETTINGS
uniform float screen_blur : hint_range(0.0, 5.0) = 0.2;

void fragment() {
	vec2 centered_uv = SCREEN_UV * 2.0 - 1.0;
	vec2 uv_offset = centered_uv.yx / curvature;
	vec2 warped_uv = centered_uv + centered_uv * uv_offset * uv_offset;
	vec3 cutoff = vec3(step(abs(warped_uv.x), 1.0) * step(abs(warped_uv.y), 1.0));
	float sine_wave = sin((warped_uv.y * scan_line_count * 2.0) - (TIME * scan_line_roll_speed));
	vec3 scanlines = vec3(sine_wave * scan_line_opacity + (1.0 - scan_line_opacity));
	vec3 vignette = vec3(length(pow(abs(centered_uv), vec2(4.0)) / vignette_softness));
	vec3 screen_color = textureLod(screen_texture, (warped_uv + 1.0) / 2.0, screen_blur).rgb * cutoff * scanlines;

	screen_color -= vignette * vignette_multiplier;

	COLOR = vec4(screen_color, 1.0);
}