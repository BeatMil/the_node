extends Node2D

export var damage = 1
export var speed = 0.3
var enemy_in_range = []


func _ready():
	# try connecting with code
	# it worked! and it is super good!
	$speed_timer.connect("timeout",self,"timer_timeout")
	$Area2D.connect("area_entered",self,"area_enter_tower")
	$Area2D.connect("area_exited",self,"area_exit_tower")

	# set fire-rate of this tower
	$speed_timer.set_wait_time(speed)
	print("default_tower.gd")


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
