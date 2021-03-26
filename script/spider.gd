extends Node2D

# config
var hp = 10


func _ready():
	pass


func get_hp():
	return hp


func set_hp(amount):
	hp = amount


func decrease_hp(amount):
	hp -= amount
