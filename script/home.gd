extends Node2D

export var hp = 10
onready var health_bar = $health_bar
signal game_over


func _ready():
	sync_health_bar()

func _on_Area2D_area_entered(area):
	if area.is_in_group("enemy"):
		var enemy = area.get_parent()
		hp -= enemy.damage # get damage from enemy.gd
		enemy.queue_free()
		sync_health_bar()

	if hp <= 0:
		emit_signal("game_over")
		print("game over! (signal emitted)")

func sync_health_bar():
	health_bar.set_value(hp)
