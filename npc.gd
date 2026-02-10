extends CharacterBody2D

@export var dialogueIndex : DialogueResource
@export var player : CharacterBody2D

signal talking
signal done_talking


func _on_talking() -> void:
	print("I'm being talked to!")
	Global.my_npc.emit(self.get_path())
	$Area2D.monitoring = false # So talking can't be spammed
	DialogueManager.show_dialogue_balloon(dialogueIndex, "start") # Starts Dialogue

func _on_done_talking() -> void:
	print("I'm done being talked to!")
	player.dialogue_status.emit()
	$Area2D.monitoring = true # Allows player to talk to npc again
