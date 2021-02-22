extends Node2D

const enemy_pre = preload("res://prefab/enemy.tscn")
export var enemy_amount = 3
var count = 0

func _ready():
	pass


func _on_Timer_timeout():
	count += 1
	var enemy = enemy_pre.instance()
	enemy.position = Vector2.ZERO
	enemy.node_number = 1
	enemy.damage = 1
	enemy.way = "../way2/"
	enemy.hp = 3
	self.add_child(enemy)
	if count == enemy_amount:
		$Timer.stop()
