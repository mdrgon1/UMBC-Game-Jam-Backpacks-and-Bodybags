extends Node

var chargeTimer = 0
var startVelocity = Vector2(0, 0)

func enter():
	owner.setAnimation("Aiming")
	
	owner.movementData.gravity = 0
	owner.movementData.friction = 1
	owner.movementData.topFallSpeed = 0
	owner.movementData.speed = 50
	owner.playerData.aimVector = (owner.getInputVector().reflect(Vector2(1, 0)) + Vector2(0, -0.1)).normalized()
	startVelocity = owner.movementData.velocity + Vector2(0, owner.fallSpeed)
	owner.fallSpeed = 0
	chargeTimer = 0

func update(delta):
	owner.movementData.targetVel = startVelocity.normalized() * owner.movementData.speed
	owner.playerData.aimVector += owner.getInputVector().reflect(Vector2(1, 0)).normalized() * 0.7
	owner.playerData.aimVector = owner.playerData.aimVector.normalized()
	chargeTimer += 1
	
	if chargeTimer > 60:
		return "Default"
	if Input.is_action_pressed(owner.inputs["swap"]) || !Input.is_action_pressed(owner.inputs["charge"]):
		return "Swap"

func exit():
	pass