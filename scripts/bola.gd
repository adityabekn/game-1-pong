extends CharacterBody2D

@export var speed: float = 400.0

var can_move: bool     = false
var direction: Vector2 = Vector2(-1, 0)

func _ready():
	# Give the ball an initial random angle
	randomize()
	var timer = get_node("%StartDelayTimer")
	timer.timeout.connect(_on_timer_timeout)

func _physics_process(delta):
	if !can_move:
		return
	
	# Update velocity
	velocity = direction * speed

	# Move and handle collisions
	var collision = move_and_collide(velocity * delta)

	if collision:
		# Bounce off surfaces
		direction = direction.bounce(collision.get_normal())

		# Optional: Slightly increase speed after each bounce
		speed *= 1.01

func reset_ball():
	# Reset ball position to center
	position = Vector2(0, 0)

	# Reset direction (randomly choose left or right)
	direction = Vector2([-1, 1].pick_random(), 0)
	direction = direction.rotated(randf_range(-PI/4, PI/4))

	# Reset speed to initial value
	speed = 400

func _on_timer_timeout():
	can_move = true
	direction = direction.rotated(randf_range(-PI/4, PI/4))