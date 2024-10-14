extends Node2D

onready var animation_players = []

func play(anim : int):
	return

func set_playback_speed(new_speed : float):
	for n in animation_players:
		n.playback_speed = new_speed
