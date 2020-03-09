extends Node
var teleportTimer = 0
var target = Vector2(0, 0)

func enter():
	owner.movementData.speed = 0
	owner.movementData.friction = 1
	owner.movementData.topFallSpeed = 0
	owner.movementData.gravity = 0
	
	teleportTimer = 0
	pass

func update(delta):
	teleportTimer += 1
	owner.movementData.targetVel = Vector2(0, 0)
	if teleportTimer > 5:
		owner.hide()
	if teleportTimer > 15:
		return "done"

func exit():
		owner.movementData.velocity = (owner.getPackPosition() - owner.position) * 3
		owner.position = owner.getPackPosition()
		owner.emit_signal("teleport")
		owner.show()
		owner.playerData.hasPack = true