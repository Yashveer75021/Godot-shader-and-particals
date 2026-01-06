extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $".."


func _on_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		var tween:Tween = create_tween()
		tween.tween_property(animated_sprite_2d.material,"shader_parameter/line_thickness", 0.5 , 0.5)
		animated_sprite_2d.play("charging")


func _on_body_exited(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		var tween:Tween = create_tween()
		tween.tween_property(animated_sprite_2d.material,"shader_parameter/line_thickness", 0.0 , 0.5)
		animated_sprite_2d.play("default")
