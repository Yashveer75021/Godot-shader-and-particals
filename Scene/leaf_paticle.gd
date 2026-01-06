extends Node2D

@onready var gpu_particles_2d: GPUParticles2D = %GPUParticles2D

func _ready() -> void:
	gpu_particles_2d.emitting = false
	$CanvasLayer/CheckButton.button_pressed = gpu_particles_2d.emitting

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var canva = get_canvas_transform()
	var size = get_viewport_rect().size/canva.get_scale()
	var screen_center = (-canva.origin / canva.get_scale()) + (size / 2)
	global_position = screen_center
	if gpu_particles_2d.process_material:
		gpu_particles_2d.process_material.emission_box_extents = Vector3(size.x / 2, size.y / 2, 1)
	

func _on_check_button_toggled(toggled_on: bool) -> void:
	gpu_particles_2d.emitting = toggled_on
