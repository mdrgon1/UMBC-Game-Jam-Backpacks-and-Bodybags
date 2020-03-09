extends Node

var fallTimer = 0

func enter():
	owner.movementData.speed = 600
	owner.movementData.friction = 0.15
	owner.movementData.topFallSpeed = 800
	owner.movementData.gravity = 10
	
	owner.playerData.throwPower = 1000
	
	fallTimer = 0
	print("running")

func update(delta):
	if Input.is_action_pressed(owner.inputs["up"]):
		return "Jumping"
	if !owner.is_on_floor() && fallTimer > 5:
		return "Falling"
	
	if owner.getInputVector().x == 0:
		owner.setAnimation("Idle")
	else:
		owner.setAnimation("Running")
	
	fallTimer += 1
	#var Motion = owner.getInputVector() * owner.movementData.speed
	owner.movementData.targetVel = Vector2(owner.getInputVector().x * owner.movementData.speed, 0)

func exit():
	pass