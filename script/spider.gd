extends Node2D

# config
var hp = 10


func _ready():
	pass


func _on_Area2D_area_entered(area):
	if area.is_in_group("attack"):
		decrease_hp(1)


func get_hp():
	return hp


func set_hp(amount):
	hp = amount


func decrease_hp(amount):
	hp -= amount
