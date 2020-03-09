extends Node

onready var statesMap = {
	"Running"	:	$Running,
	"Jumping"	:	$Jumping,
	"Falling"	:	$Falling
}

onready var currentState = $Falling

#Always starts out falling
func enter():
	currentState = statesMap["Falling"]
	statesMap["Falling"].enter()

#Exits the current low level state and enters the new one
func update_state(newState):
	if newState:
		if(statesMap[newState] != currentState):
			currentState.exit()
			currentState = statesMap[newState]
			currentState.enter()

func update(delta):
	if (owner.is_on_floor() || owner.is_on_wall()) && Input.is_action_just_pressed(owner.inputs["jump"]):
		update_state("Jumping")
	
	update_state(currentState.update(delta))

func exit():
	pass