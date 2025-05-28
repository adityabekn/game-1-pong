extends CharacterBody2D

@export var speed: float = 300

var can_move: bool     = false
var direction: Vector2 = Vector2(-1, 0)

@onready var timer: Node = get_node("%StartDelayTimer")
@onready var goal_area: Node = get_node("%LeftGoal")
@onready var goal_area_2: Node = get_node("%RightGoal")

func _ready():
	# Give the ball an initial random angle
	randomize()
	timer.timeout.connect(_on_timer_timeout)
	goal_area.ball_hit_score.connect(reset_ball)
	goal_area_2.ball_hit_score.connect(reset_ball)
	timer.start()

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
	can_move = false
	position = Vector2(320, 176)

	# Reset direction (randomly choose left or right)
	direction = Vector2([-1, 1].pick_random(), 0)
	direction = direction.rotated(randf_range(-PI/4, PI/4))

	# Reset speed to initial value
	speed = 300

	timer.start()

func _on_timer_timeout():
	can_move = true
	direction = direction.rotated(randf_range(-PI/4, PI/4))