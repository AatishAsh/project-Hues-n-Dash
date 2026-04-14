shader_type canvas_item;

// This grabs whatever the camera is currently seeing!
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

// Dials you can tweak in the Inspector
uniform float scanline_count : hint_range(0.0, 1080.0) = 200.0;
uniform float curvature : hint_range(0.0, 10.0) = 4.0;
uniform float vignette_multiplier = 3.0;

void fragment() {
	// 1. Curve the screen
	vec2 uv = SCREEN_UV;
	uv = uv * 2.0 - 1.0;
	vec2 offset = abs(uv.yx) / vec2(curvature);
	uv = uv + uv * offset * offset;
	uv = uv * 0.5 + 0.5;

	// 2. Black out the edges if the curve pulls the image too far
	if (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0) {
		COLOR = vec4(0.0, 0.0, 0.0, 1.0);
	} else {
		// 3. Grab the game's colors at the new curved coordinates
		vec4 color = texture(screen_texture, uv);

		// 4. Add Scanlines (horizontal black lines)
		float scanlines = 0.5 - cos(uv.y * scanline_count * PI * 2.0) * 0.5;
		color.rgb -= scanlines * 0.15; // Tweak the 0.15 to make lines darker/lighter

		// 5. Add Vignette (darken the corners)
		float vignette = uv.x * uv.y * (1.0 - uv.x) * (1.0 - uv.y);
		color.rgb *= clamp(pow((vignette * 15.0), 0.25) * vignette_multiplier, 0.0, 1.0);

		COLOR = color;
	}
}