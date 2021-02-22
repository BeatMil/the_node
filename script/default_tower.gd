extends Node2D

export var damage = 1

# speed_timer connect to timeout with area passed in
# I have no idea how to do it the right way so.. I do this way!
var timer_helper = false 

func _ready():
	print("default_tower.gd")


func _on_Area2D_area_entered(area):
	if not timer_helper:
		$speed_timer.connect("timeout",self,"beat_test",[area])
		timer_helper = true

	$speed_timer.start()


func _on_Area2D_area_exited(area):
	pass # Replace with function body.


func beat_test(area):
	# check if area is still there
	if area:
		area.get_parent().decrease_hp(1)
