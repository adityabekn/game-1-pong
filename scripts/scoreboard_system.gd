extends Node

var player1_score: int = 0
var player2_score: int = 0

@onready var scored_timer: Node = get_node('%ScoredTimer')
@onready var pong: Node = get_node('%Pong')

func _ready():
	update_score_display()
	$LeftGoal.connect("ball_hit_score", _on_left_goal_scored)
	$RightGoal.connect("ball_hit_score", _on_right_goal_scored)
	
	scored_timer.timeout.connect(_on_scored_timer_timeout)

func _on_left_goal_scored():
	player2_score += 1
	update_score_display()
	scored_animation()
#	reset_ball()

func _on_right_goal_scored():
	player1_score += 1
	update_score_display()
	scored_animation()
#	reset_ball()

func update_score_display():
	get_node('%ScoreboardUI/Player1Score').text = str(player1_score)
	get_node('%ScoreboardUI/Player2Score').text = str(player2_score)
#	$ScoreboardUI/Player1Score.text = str(player1_score)
#	$ScoreboardUI/Player2Score.text = str(player2_score)

func scored_animation():
	# set the pong visible true
	pong.visible = true
	
	# after that start the timer
	scored_timer.start()
	
func _on_scored_timer_timeout():
	pong.visible = false
