extends "res://scripts/Skeleton_default.gd"

var current_anim = -1
enum {Idle, Swimming, Dash, SuperIdle}

func _ready():
	animation_players = [$Animation]

func set_anim_speed(speed : float):
	$Animation.playback_speed = speed

func play(anim : int):
	if anim == current_anim:
		return
	current_anim = anim
	if anim == Idle:
		$Animation.play("idle")
	elif anim == Swimming:
		$Animation.play("swim")
	elif anim == Dash:
		$Animation.play("dash")
	elif anim == SuperIdle:
		$Animation.play("super_idle")

