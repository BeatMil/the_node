extends Node2D

func _ready():
	$"enemy/ani_player".play("intro")
	$"spider/ani_player".play("intro")


func _on_ani_player_animation_finished(anim_name):
	if anim_name == "intro":
		$"boss_health_bar/ani_player".play("intro")
