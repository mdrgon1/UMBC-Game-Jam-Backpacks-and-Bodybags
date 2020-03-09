extends Node

onready var statesMap = {
	"Blocking"	:	$Blocking,
	"Punching"	:	$Punching
}

onready var currentState = $Blocking

#enters blocking or punching based on user input
func enter():
	if Input.is_action_pressed(owner.inputs["down"]):
		currentState = statesMap["Blocking"]
		statesMap["Blocking"].enter()
		owner.playerData.blocking = true
	else:
		currentState = statesMap["Punching"]
		statesMap["Punching"].enter()
		owner.playerData.attacking = true

#Exits the current low level state and enters the new one
func update_state(newState):
	if newState:
		if(statesMap[newState] != currentState):
			currentState.exit()
			currentState = statesMap[newState]
			currentState.enter()

func update(delta):
	
	if !owner.playerData.blocking && !owner.playerData.attacking:
		return "Moving"
	
	update_state(currentState.update(delta))
	
func exit():
	owner.playerData.attacking = false
	owner.playerData.blocking = false
	pass