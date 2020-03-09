extends Node

const JUMP_FORCE = 800

var jumpTimer = 0

func enter():
	owner.setAnimation("Falling")
	
	owner.movementData.gravity = 14
	owner.movementData.friction = 0.1
	owner.movementData.topFallSpeed = 700
	owner.movementData.speed = 600
	
	var jumpVector = (owner.getContactVector(20) + owner.getInputVector().reflect(Vector2(1, 0)) + Vector2(0, -1)).normalized() * JUMP_FORCE
	
	jumpTimer = 0
	
	owner.movementData.velocity.x = jumpVector.x
	owner.fallSpeed = jumpVector.y
	
	print("jumping")

func update(delta):
	if !Input.is_action_pressed(owner.inputs["jump"]):
		return "Falling"
		
	owner.movementData.targetVel = owner.getInputVector() * owner.movementData.speed
	
	if owner.is_on_floor() && jumpTimer > 10:
		return "Running"
	
	jumpTimer += 1

func exit():
	pass