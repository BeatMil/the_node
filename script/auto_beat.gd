extends Node

var is_blocked = false # can't spawn tower if another tower is already there


func set_is_blocked(boolean):
	is_blocked = boolean
