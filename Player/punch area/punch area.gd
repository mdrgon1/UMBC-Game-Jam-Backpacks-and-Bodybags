extends Area2D

func _physics_process(delta):
	if owner.playerData.attacking:
		set_collision_layer_bit(0, 1)
		set_collision_mask_bit(0, 1)
	else:
		set_collision_layer_bit(0, 0)
		set_collision_mask_bit(0, 0)
	if Input.is_action_pressed(owner.inputs["right"]):
		scale = Vector2(1, 1)
	if Input.is_action_pressed(owner.inputs["left"]):
		scale = Vector2(-1, 1)