extends CharacterBody2D

@export var speed: float = 300
@export var dead_zone: float = 10

@onready var ball = get_node("%Bola")

func _physics_process(delta: float) -> void:
	if ball:
		# Only move if the ball is sufficiently far from the paddle
		var distance = ball.position.y - position.y
		if abs(distance) > dead_zone:
			var direction = sign(distance)
			velocity = Vector2(0, direction * speed)
		else:
			velocity = Vector2.ZERO

		move_and_slide()