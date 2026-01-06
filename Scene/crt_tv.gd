extends MeshInstance2D

# Assign your Camera2D here in the Inspector
@export var game_camera: Camera2D

func _process(_delta):
	if game_camera:
		# Get the current zoom (usually x and y are the same)
		var current_zoom = game_camera.zoom.y
		
		# Send it to the shader
		material.set_shader_parameter("camera_zoom", current_zoom)
