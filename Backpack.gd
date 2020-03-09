extends RigidBody2D

var attached = true

onready var player = get_node("../Player1")

func _ready():
	if position.x > 0:
		player = get_node("../Player1")
	if position.x < 0:
		player = get_node("../Player2")

func _physics_process(delta):
	if attached && position.y < 1000:
		set_axis_velocity((player.position - position) * 400)
		apply_torque_impulse(-rotation)
		linear_damp = 50
		angular_damp = 10
		set_collision_layer_bit(1, 0)
		set_collision_mask_bit(1, 0)
		$backpackHurtBox.set_scale(Vector2(0, 0))
	else:
		set_collision_layer_bit(1, 1)
		set_collision_mask_bit(1, 1)
		$backpackHurtBox.set_scale(Vector2(1, 1))

func _on_Player1_throwing(direction, power):
	linear_damp = 0
	angular_damp = 30
	set_axis_velocity(direction * power)
	attached = false

func _on_Player1_teleport():
	linear_velocity = Vector2(0, 0)
	position = player.position
	attached = true
