extends Node2D
# I'm sure you know how num works right?
# if not then I guess you can... google
# sorry to be an asshole lol
enum {
		UP,
		DOWN,
		LEFT,
		RIGT
}
var speed = 8

export var direction = DOWN


func _ready():
	move()


func _physics_process(delta):
	pass


func move():
	var current_pos = self.global_position
	var tween = get_node("Tween")
	tween.interpolate_property(self, "position",
			current_pos, current_pos + Vector2(0, 800), 1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
