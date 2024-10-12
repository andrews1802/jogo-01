extends CharacterBody2D


const SPEED = 120
const JUMP_FORCE = -330.0

@onready var animaition:= $anim as AnimatedSprite2D


func _physics_process(delta: float) -> void:
	var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	var is_jumping := false 
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_FORCE
		is_jumping = true 
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if !is_jumping:
			animaition.play("run")
	elif is_jumping:
			animaition.play("jump")	
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animaition.play("idle")
	move_and_slide()
