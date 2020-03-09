extends Node

func enter():
	owner.setAnimation("Falling")
	
	owner.movementData.gravity = 17
	owner.movementData.friction = 0.1
	owner.movementData.topFallSpeed = 700
	owner.movementData.speed = 400
	
	print("falling")

func update(delta):
	
	owner.movementData.targetVel.x = owner.getInputVector().x * owner.movementData.speed
	
	if owner.is_on_floor():
		return "Running"
		
func exit():
	pass