extends Node

# modes
var spawn_mode = false
var delete_mode = false
var bomb_mode = false


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
	print("spawn_mode: %s"%boolean)


func set_delete_mode(boolean):
	delete_mode = boolean
	print("delete_mode: %s"%boolean)


func set_bomb_mode(boolean):
	bomb_mode = boolean
	print("bomb_mode: %s"%boolean)


func buy_small_tower():
	money -= small_tower_price


func turn_off_all_mode():
	spawn_mode = false
	delete_mode = false
	bomb_mode = false

# toggle off all buttons in button node
# so that play can go from spawn mode to delete mode with out having to
# click spawn mode to turn it off
func toggle_off_button_except(button_name):
	var beat = get_tree().get_nodes_in_group("head")
	var buttons = beat[0].get_node("buttons").get_children()
	for button in buttons:
		if button.is_in_group("button"):
			if button.name != button_name:
				button.get_node("Button").set_pressed(false)
