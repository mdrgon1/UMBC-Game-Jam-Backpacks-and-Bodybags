extends Sprite

func _process(delta):
	scale.x = owner.playerData.health * 0.01