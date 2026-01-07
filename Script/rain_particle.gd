extends Node2D

@onready var gpu_particles_rain: GPUParticles2D = %"GPUParticles-rain"
@export_category("Rain Settings")
@export var rain_amount:int = 1000
# Increase this margin until the gap disappears (try 300 or 400 if moving fast)
@export var rain_buffer_margin: Vector2 = Vector2(400, 400)
@export var rain_gravity:Vector3 = Vector3(0,1000.0,0)



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gpu_particles_rain.emitting = false
	set_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var canva = get_canvas_transform()
	var visible_size = get_viewport_rect().size/canva.get_scale()
	var emission_size = visible_size + rain_buffer_margin
	var screen_center = (-canva.origin / canva.get_scale()) + (visible_size / 2)
	global_position = screen_center
	if gpu_particles_rain.process_material:
		gpu_particles_rain.process_material.emission_box_extents = Vector3(emission_size.x / 2, emission_size.y / 2, 1)	
		gpu_particles_rain.amount = rain_amount
		gpu_particles_rain.process_material.gravity = rain_gravity
		
func _on_check_button_toggled(toggled_on: bool) -> void:
	gpu_particles_rain.emitting = toggled_on
	set_process(toggled_on)
