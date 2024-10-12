extends Node2D

const WAIT_DURATION := 1.0

@onready var platform := $plata as AnimatableBody2D
@export var movie_speed := 3.0
@export var disntance := 192 
@export var movie_horizonta := true 

var follow := Vector2.ZERO
var platform_center := 16 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	move_platform()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	platform.position = platform.position.lerp(follow, 0.5)
func move_platform():
	var move_direction = Vector2.RIGHT * disntance if movie_horizonta else Vector2.UP * disntance
	var duration = move_direction.length() / float(movie_speed * platform_center)
	
	var platform_tween = create_tween().set_loops().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	platform_tween.tween_property(self, "follow", move_direction, duration).set_delay(WAIT_DURATION)
	platform_tween.tween_property(self, "follow", Vector2.ZERO, duration).set_delay(duration + WAIT_DURATION * 2)
