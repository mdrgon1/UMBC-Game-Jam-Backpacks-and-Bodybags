extends Node

var throwTimer = 0

func enter():
	owner.setAnimation("Throwing")
	owner.movementData.speed = 0
	owner.movementData.friction = 0
	owner.movementData.topFallSpeed = 0
	owner.movementData.gravity = 0
	
	owner.throw()

func update(delta):
	if throwTimer > 20:
		return "done"
	
	throwTimer += 1
	
func exit():
	owner.playerData.hasPack = false
	owner.playerData.throwPower *= 0.8
	pass