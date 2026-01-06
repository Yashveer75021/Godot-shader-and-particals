extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Gravity settings
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim_sprite = $AnimatedSprite2D

func _physics_process(delta):
	# 1. Gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# 2. Jump
		#do it yourself :)
	# 3. Movement
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# 4. Move
	move_and_slide()

	# --- ANIMATION UPDATE ---
	update_animation(direction)

func update_animation(direction):
	# FLIP: Face Left or Right
	if direction > 0:
		anim_sprite.flip_h = false
	elif direction < 0:
		anim_sprite.flip_h = true

	# ANIMATION STATES
	if is_on_floor():
		# Zameen par hai
		if direction != 0:
			anim_sprite.play("walk")
		else:
			anim_sprite.play("idle")
