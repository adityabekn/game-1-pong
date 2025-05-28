extends CharacterBody2D

@export var speed: float = 300
@export var dead_zone: float = 10
@export var smoothing: float = 0.1  # Lower = smoother, but slower response

@onready var ball: Node       = get_node("%Bola")
var target_position_y: float  = 0.0
var initial_position_y: float = 180  # Middle of the screen

func _ready():
	# Initialize target position to current position
	target_position_y = position.y
	# Connect to ball's reset signal
	if ball:
		ball.get_node("%LeftGoal").ball_hit_score.connect(_on_ball_reset)
		ball.get_node("%RightGoal").ball_hit_score.connect(_on_ball_reset)

func _physics_process(delta: float) -> void:
	if ball:
		if ball.position.x > get_viewport_rect().size.x / 2:
			# Update target position only when needed
			target_position_y = ball.position.y

		# Smoothly move towards target position
		var current_distance: float = target_position_y - position.y
		if abs(current_distance) > dead_zone:
			# Interpolate the velocity instead of setting it directly
			var desired_velocity = sign(current_distance) * speed
			velocity.y = lerp(velocity.y, desired_velocity, smoothing)
		else:
			# Smoothly come to a stop
			velocity.y = lerp(velocity.y, 0.0, smoothing)

		move_and_collide(velocity * delta)

func _on_ball_reset():
	# When ball resets, set target position to middle
	target_position_y = initial_position_y
