extends Node2D


# preload
const ATTACK2 = preload("res://prefab/boss/attack2.tscn")
const MOUSE = preload("res://prefab/boss/boss_cursor.tscn")
const DIALOG1 = preload("res://prefab/boss/dialog1.tscn")
var heart_mouse = load("res://prefab/boss/heart1.png")

# play intro animation
func _ready():
	$"enemy/ani_player".play("intro")
	$"spider/ani_player".play("intro")


# intro animation
func _on_ani_player_animation_finished(anim_name):
	if anim_name == "intro":
		$"boss_health_bar/ani_player".play("intro")


func _on_Timer_timeout():
	spawn_dialog(DIALOG1)
	Input.set_custom_mouse_cursor(heart_mouse)
	# spawn_attack1()


func spawn_attack1():
	var attack2 = ATTACK2.instance()
	attack2.position = $attack2_pos.position
	self.add_child(attack2)


func spawn_mouse():
	var mouse = MOUSE.instance()
	mouse.position = get_global_mouse_position()
	self.add_child(mouse)


func spawn_dialog(dialoog):
	var dialog = dialoog.instance()
	dialog.position = $dialog_pos.position
	self.add_child(dialog)

