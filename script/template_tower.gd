extends Node2D

export var damage = 1
export var speed = 0.3
var enemy_in_range = []
onready var auto_beat = get_node("/root/AutoBeat")


func _ready():
	# try connecting with code
	# it worked! and it is super good!
	$speed_timer.connect("timeout",self,"timer_timeout")
	$Area2D.connect("area_entered",self,"area_enter_tower")
	$Area2D.connect("area_exited",self,"area_exit_tower")

	# set fire-rate of this tower
	$speed_timer.set_wait_time(speed)


func area_enter_tower(area):
	# pushes area(enemy) into array
	# always fire to the first index of the array
	if area.is_in_group("enemy"):
		if enemy_in_range.empty():
			$speed_timer.start()
			enemy_in_range.push_back(area)
		else:
			enemy_in_range.push_back(area)


func area_exit_tower(area):
	# area(enemy) leaves the area
	# pop them out of the array
	enemy_in_range.pop_front()
	if enemy_in_range.empty():
		$speed_timer.stop()


func timer_timeout():
	# check if area is still there
	# and decrease its hp
	if enemy_in_range.front():
		enemy_in_range.front().get_parent().decrease_hp(1)


func _on_Area2D_mouse_entered():
	auto_beat.set_is_blocked(true)
	# defend agaisnt when node not found
	if get_parent().get_node_or_null("buttons/mouse_grid"):
		get_parent().get_node_or_null("buttons/mouse_grid").set_color_red()

func _on_Area2D_mouse_exited():
	auto_beat.set_is_blocked(false)
	# defend agaisnt when node not found
	if get_parent().get_node_or_null("buttons/mouse_grid"):
		get_parent().get_node_or_null("buttons/mouse_grid").set_color_green()


func _on_hurtbox_input_event(viewport, event, shape_idx):
	if event is InputEventMouseMotion:
		auto_beat.set_is_blocked(true)
		# defend agaisnt when node not found
		if get_parent().get_node_or_null("buttons/mouse_grid"):
			print(get_parent().get_node_or_null("buttons/mouse_grid").name)
			get_parent().get_node_or_null("buttons/mouse_grid").set_color_red()
