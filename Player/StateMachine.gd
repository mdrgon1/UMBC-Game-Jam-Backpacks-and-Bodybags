extends KinematicBody2D

signal throwing(direction, power)
signal teleport

#Manages transitions between top level states
const UP = Vector2(0, -1)

#Holds references to all top level states
onready var statesMap = {
	"Default"	:	$Default,
	"Charge"	:	$Charge,
	"Swap"		:	$Swap,
	"Stagger"	:	$Stagger
}

var P1Keymap = {
	"up"	:	"P1_up",
	"left"	:	"P1_left",
	"right"	:	"P1_right",
	"down"	:	"P1_down",
	"jump"	:	"P1_jump",
	"swap"	:	"P1_swap",
	"hit"	:	"P1_hit",
	"charge":	"P1_charge"
}

var P2Keymap = {
	"up"	:	"P2_up",
	"left"	:	"P2_left",
	"right"	:	"P2_right",
	"down"	:	"P2_down",
	"jump"	:	"P2_jump",
	"swap"	:	"P2_swap",
	"hit"	:	"P2_hit",
	"charge":	"P2_charge"
}

onready var currentState = $Default

#holds all movement data for the player in one structure
var movementData = {
	gravity = 10,
	friction = 0.9,
	targetVel = Vector2(0, 0),
	velocity = Vector2(0, 0),
	speed = 20,
	topFallSpeed = 400
}

var playerData = {
	health = 100,
	blocking = false,
	attacking = false,
	aimVector = Vector2(1, 0),
	hasPack = true,
	hidden = false,
	backpack = get_node("../backpack1"),
	throwPower = 1000,
	enemy = get_node("../Player2"),
	enemyBackpack = get_node("../backpack2"),
	staggered = false
}

var fallSpeed = 0
var inputs = P1Keymap

#Determines the keymap based on the initial position (I know shut the fuck up)
func _ready():
	if position.x > 0:
		inputs = P1Keymap
		playerData.backpack = get_node("../Backpack1")
		playerData.enemyBackpack = get_node("../Backpack2")
		playerData.enemy = get_node("../Player2")
	if position.x < 0:
		inputs = P2Keymap
		playerData.backpack = get_node("../Backpack2")
		playerData.enemyBackpack = get_node("../Backpack1")
		playerData.enemy = get_node("../Player1")

#Exits current state and enters the new one
func update_state(newState):
	if newState:
		if(statesMap[newState] != currentState):
			currentState.exit()
			currentState = statesMap[newState]
			currentState.enter()

#Updates position and velocity and runs top level update function
func _physics_process(delta):
	
	if position.y > 1000 || position.y < -500 || position.x > 1000 || position.x < -1000 || playerData.health <= 0:
		position = Vector2(0, 400)
		playerData.hasPack = true
		emit_signal("teleport")
		fallSpeed = 0
		movementData.velocity = Vector2(0, 0)
		playerData.health = 100
		emit_signal("Died")
	
	movementData.velocity += (movementData.targetVel - movementData.velocity) * movementData.friction
	if playerData.attacking:
		fallSpeed = 0
	if is_on_floor():
		fallSpeed = 10
	elif fallSpeed < movementData.topFallSpeed:
		fallSpeed += movementData.gravity
	else:
		fallSpeed = movementData.topFallSpeed
	
	if movementData.targetVel.x > 1:
		$PlayerSprite.set_flip_h(false)
	if movementData.targetVel.x < -1:
		$PlayerSprite.set_flip_h(true)
	
	update_state(currentState.update(delta))
	
	move_and_slide(movementData.velocity + Vector2(0, fallSpeed), UP)

func getInputVector():
	var output = Vector2(0, 0)
	output.x += int(Input.is_action_pressed(inputs["right"]))
	output.x -= int(Input.is_action_pressed(inputs["left"]))
	output.y += int(Input.is_action_pressed(inputs["up"]))
	output.y -= int(Input.is_action_pressed(inputs["down"]))
	return output

func getContactVector(distance):
	var from = Transform2D(rotation, position)
	var outputVector = Vector2(0, 0)
	outputVector.x += int(test_move(from, Vector2(-distance, 0), true ))
	outputVector.x -= int(test_move(from, Vector2(distance, 0), true ))
	outputVector.y += int(test_move(from, Vector2(0, -distance), true ))
	outputVector.y -= int(test_move(from, Vector2(0, distance), true ))
	return outputVector

func getPackPosition():
	return playerData.backpack.position

func throw():
	emit_signal("throwing", playerData.aimVector, playerData.throwPower)
	pass

func hide():
	$AimSprite.hide()
	$PlayerSprite.hide()
	$PlayerSprite.hide()
	playerData.hidden = false

func show():
	$AimSprite.show()
	$PlayerSprite.show()
	$PlayerSprite.show()
	playerData.hidden = true

func _on_Area2D_area_entered(area):
	print(str(area.owner))
	if area.name == "punch area" && !playerData.staggered && !playerData.blocking:
		playerData.health -= 5
		update_state("Stagger")
	if area.owner == playerData.enemyBackpack && !playerData.staggered && !playerData.blocking:
		playerData.health -= 15
		update_state("Stagger")

func setAnimation(animation):
	$PlayerSprite.set_animation(animation)
