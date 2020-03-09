extends Node
#Manages normal movement and combat

#Hold references to mid tier default states
onready var statesMap = {
	"Moving"	:	$Moving,
	"Combat"	:	$Combat
}

onready var currentState = $Moving

#Always enters the default state in movement
func enter():
	currentState = $Moving
	currentState.enter()

#Exits the current mid level state and enters the new one
func update_state(newState):
	if newState:
		if(statesMap[newState] != currentState):
			currentState.exit()
			currentState = statesMap[newState]
			currentState.enter()
	
func update(delta):
	if Input.is_action_just_pressed(owner.inputs["hit"]):
		update_state("Combat")
	if Input.is_action_just_pressed(owner.inputs["charge"]) && currentState == statesMap["Moving"]:
		return "Charge"
	if Input.is_action_pressed(owner.inputs["swap"]) && !owner.playerData.hasPack:
		return "Swap"
	
	
	update_state(currentState.update(delta))

func exit():
	pass