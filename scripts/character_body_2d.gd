extends CharacterBody2D

@export var SPEED: float = 300.0

func _physics_process(delta: float) -> void:
	var direction: Vector2 = Vector2.ZERO

	# Get input direction
	if Input.is_action_pressed("ui_up"):
		direction.y = -1
	if Input.is_action_pressed("ui_down"):
		direction.y = 1

	# Set the velocity
	velocity = direction * SPEED

	# Move and slide will handle the movement and collision
	move_and_slide()