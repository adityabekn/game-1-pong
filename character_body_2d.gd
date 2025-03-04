extends Node2D

@export var SPEED: float = 300.0

func _process(delta: float):
	var direction: int = 0;
	if Input.is_action_pressed("ui_up"):
		print("Up")
		direction = -1;
			
	if Input.is_action_pressed("ui_down"):
		print("Down")
		direction = 1;

	# Apply movement
	position.y += direction * SPEED * delta