extends Node

# modes
var spawn_mode = false
var delete_mode = false


# helpers
var is_blocked = false # can't spawn tower if another tower is already there


# money and stuff
var money = 1000 # money! buy towers!


# towers price
# NOTE: I dont know where to put the price so it's here for now.
var small_tower_price = 200


func set_is_blocked(boolean):
	is_blocked = boolean


func set_spawn_mode(boolean):
	spawn_mode = boolean


func set_delete_mode(boolean):
	delete_mode = boolean


func buy_small_tower():
	money -= small_tower_price


func turn_off_all_mode_except(button_name):
	var beat = get_tree().get_nodes_in_group("head")
	var buttons = beat.get_node("buttons").get_children()
	print(buttons)
	
