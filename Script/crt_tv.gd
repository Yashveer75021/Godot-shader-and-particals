extends Node2D

@onready var mesh_instance_2d: MeshInstance2D = $CanvasLayer/MeshInstance2D

@export_category("CRT Settings")
## 2.0 = Retro (1 line every 2 pixels). 1.0 = HD (1 line every pixel).
@export var scanline_density: float = 2.0
@export var match_camera_zoom: bool = true

func _ready() -> void:
	mesh_instance_2d.visible = false	
	set_process(true)

func _process(_delta):
	var screen_height = get_viewport_rect().size.y
	var calculated_count = screen_height / scanline_density
	
	if match_camera_zoom:
		var active_camera = get_viewport().get_camera_2d()
		
		if active_camera:
			var current_zoom = max(active_camera.zoom.y, 0.001)
			calculated_count = calculated_count / current_zoom

	if mesh_instance_2d.material:
		mesh_instance_2d.material.set_shader_parameter("scan_line_count", calculated_count)

func _on_toggle_crt_button_toggled(toggled_on: bool) -> void:
	mesh_instance_2d.visible = toggled_on
	set_process(toggled_on)
