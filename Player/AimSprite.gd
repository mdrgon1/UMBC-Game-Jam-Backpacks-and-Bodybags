extends Sprite

func _physics_process(delta):
	rotation = owner.playerData.aimVector.angle()