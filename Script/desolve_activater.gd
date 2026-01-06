extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $".."
@export var time: float = 1.5
var cooldowntime:float = 1.0

func _on_body_entered(body: Node2D) -> void:
	if body.name == 'CharacterBody2D':
		var tween: Tween = create_tween()
		tween.tween_property(animated_sprite_2d.material, "shader_parameter/dissolve_value", 1.0, time)


func _on_body_exited(body: Node2D) -> void:
	if body.name == 'CharacterBody2D':
		var tween: Tween = create_tween()
		tween.tween_property(animated_sprite_2d.material, "shader_parameter/dissolve_value", 0.0, time)
