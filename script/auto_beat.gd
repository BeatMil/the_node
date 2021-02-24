extends Node

var spawn_mode = false
var is_blocked = false # can't spawn tower if another tower is already there


func set_is_blocked(boolean):
	is_blocked = boolean


func set_spawn_mode(boolean):
	spawn_mode = boolean
