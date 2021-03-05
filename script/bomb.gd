extends Node2D

var damage = 25

# timer auto start and one shot
# this bomb node will be spawned by the bomb button
# then this will explode (queue_free itself)
# dealing 3 damage to node in group "enemy"

func _on_Area2D_area_entered(area):
	if area.is_in_group("enemy"):
		area.get_parent().decrease_hp(damage)


func _on_Timer_timeout():
	queue_free()
