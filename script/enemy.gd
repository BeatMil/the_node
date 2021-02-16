extends Node2D

export var group = 1
export var node_number = 1
export var speed = 0.2


# beat function helper
var is_moving = false # making it move linearly helper
var the_position = Vector2.ZERO
var node_position = Vector2.ZERO

func _ready():
	pass # Replace with function body.


func _physics_process(_delta):
	if node_number <= 0:
		node_number = 1
	elif node_number == 1:
		# move to node #1
		follow_mouse($"../way1/1")
		pass


# beat function
func move_to_node(node, delta):
	if not is_moving:
		var current_postion = $".".position
		node_position = node.position
		the_position = node_position - current_postion
		is_moving = true
	elif is_moving:
		print(the_position)
		# keep moving until the destination
		if $".".get_position() <= node_position:
			move_local_x(the_position.x * delta * speed)
			move_local_y(the_position.y * delta * speed)


# Jero function
func follow_mouse(node):
	var motionx = (node.position.x - position.x) * speed
	var motiony = (node.position.y - position.y) * speed
	translate(Vector2(motionx, motiony))

# the tween fucnction
func tween_move(node):
	var current_position = $".".get_position()
	var desination = node.get_position()
	var tween = get_node("Tween")
	tween.interpolate_property($".", "position",
		current_position, desination, 5,
		Tween.TRANS_BOUNCE, Tween.EASE_OUT_IN)
	tween.start()

