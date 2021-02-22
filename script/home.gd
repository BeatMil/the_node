extends Node2D

export var hp = 10
signal game_over

func _ready():
	print("home HP: %s"%hp)


func _on_Area2D_area_entered(area):
	if area.is_in_group("enemy"):
		hp -= area.get_parent().damage # get damage from enemy.gd
	print("home HP: %s"%hp)

	if hp <= 0:
		emit_signal("game_over")
		print("game over! (signal emitted)")

