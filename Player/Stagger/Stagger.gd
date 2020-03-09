extends Node

var staggerTimer = 0

func enter():
	owner.setAnimation("Stagger")
	
	owner.movementData.speed = 0
	owner.movementData.friction = 1
	owner.movementData.topFallSpeed = 0
	owner.movementData.gravity = 0
	owner.playerData.staggered = true
	
	staggerTimer = 0

func update(delta):
	if staggerTimer > 15:
		return "Default"
	
	staggerTimer += 1

func exit():
	owner.playerData.staggered = false