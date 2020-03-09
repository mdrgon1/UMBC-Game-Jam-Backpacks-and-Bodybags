extends Node

onready var statesMap = {
	"Throwing"	:	$Throwing,
	"Teleport"	:	$Teleport
}

onready var currentState = statesMap["Throwing"]

func update_state(newState):
	if newState:
		if newState == "done":
			currentState.exit()
			return "done"
		if(statesMap[newState] != currentState):
			currentState.exit()
			currentState = statesMap[newState]
			currentState.enter()

func enter():
	if owner.playerData.hasPack:
		currentState = statesMap["Throwing"]
		statesMap["Throwing"].enter()
	elif Input.is_action_just_pressed(owner.inputs["swap"]):
		currentState = statesMap["Teleport"]
		statesMap["Teleport"].enter()

func update(delta):
	if update_state(currentState.update(delta)) == "done":
		return "Default"

func exit():
	pass