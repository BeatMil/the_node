extends Node2D


# preload the attacks
const ATTACK1 = preload("res://prefab/boss/attack1.tscn")
const MOUSE = preload("res://prefab/boss/boss_cursor.tscn")

# play intro animation
func _ready():
	$"enemy/ani_player".play("intro")
	$"spider/ani_player".play("intro")


# intro animation
func _on_ani_player_animation_finished(anim_name):
	if anim_name == "intro":
		$"boss_health_bar/ani_player".play("intro")


func _on_Timer_timeout():
	spawn_attack1()
	spawn_mouse()


func spawn_attack1():
	var attack1 = ATTACK1.instance()
	attack1.position = $attack1_pos.position
	self.add_child(attack1)


func spawn_mouse():
	var mouse = MOUSE.instance()
	mouse.position = get_global_mouse_position()
	self.add_child(mouse)
	pass
