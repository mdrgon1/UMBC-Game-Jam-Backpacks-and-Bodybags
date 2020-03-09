extends Node

var punchTimer = 0
var startVelocity = Vector2(1, 0)

func enter():
	owner.setAnimation("Punching")
	
	owner.movementData.gravity = 0
	owner.movementData.friction = 1
	owner.movementData.topFallSpeed = 0
	owner.movementData.speed = 10
	startVelocity = owner.movementData.velocity.normalized().x
	punchTimer = 0

func update(delta):
	if punchTimer > 3:
		owner.playerData.attacking = true
	if punchTimer > 15:
		owner.playerData.attacking = false
	
	punchTimer += 1
	
	owner.movementData.targetVel = Vector2(startVelocity * 100, 0)

func exit():
	pass