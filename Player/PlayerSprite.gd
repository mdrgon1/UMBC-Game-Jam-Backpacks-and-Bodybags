extends AnimatedSprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	if owner.position.x > 0:
		set_self_modulate(Color(1, 1, 1))
	if owner.position.x < 0:
		set_self_modulate(Color(0, 2.33, 3.49))