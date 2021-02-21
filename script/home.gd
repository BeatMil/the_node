extends Node2D

export var hp = 10


func _ready():
	print("home HP: %s"%hp)


func _on_Area2D_area_entered(area):
	if area.is_in_group("enemy"):
		hp -= area.get_parent().damage # get damage from enemy.gd
	print("home HP: %s"%hp)
