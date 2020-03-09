extends Node

var blockTimer = 0
var startVelocity = Vector2(0, 0)

func enter():
	owner.setAnimation("Blocking")
	
	owner.fallSpeed = 0
	owner.movementData.gravity = 10
	owner.movementData.friction = 1
	owner.movementData.topFallSpeed = 300
	owner.movementData.speed = 10
	startVelocity = (owner.movementData.velocity).normalized().x
	blockTimer = 0

func update(delta):
	if blockTimer > 5:
		owner.playerData.blocking = true
		if Input.is_action_pressed(owner.inputs["down"]) && Input.is_action_pressed(owner.inputs["hit"]):
			blockTimer = 6
	if blockTimer > 10:
		owner.playerData.blocking = false
	
	blockTimer += 1
	
	owner.movementData.targetVel = Vector2(startVelocity * 50 * (1 - blockTimer / 6), 0)

func exit():
	pass