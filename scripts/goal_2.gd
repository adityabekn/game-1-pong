extends Area2D

signal ball_hit_score

func _on_body_entered(body):
	if body.name == "Bola":
		emit_signal("ball_hit_score")

func _ready():
	connect("body_entered", _on_body_entered)
