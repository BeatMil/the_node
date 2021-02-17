extends Node2D

export var hp = 10


func _ready():
	print("home HP: %s"%hp)
	pass # Replace with function body.


func _on_Area2D_area_entered(area):
	if area.is_in_group("enemy"):
		hp -= 1
	print("home HP: %s"%hp)
