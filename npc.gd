extends CharacterBody2D

@export var dialogueIndex : DialogueResource
@export var player : CharacterBody2D

var inCombat : bool = false

signal talking
signal done_talking


func _on_talking() -> void:
	if inCombat == false:
		print("I'm being talked to!")
		Global.my_npc.emit(self.get_path())
		$Area2D.monitoring = false # So talking can't be spammed
		DialogueManager.show_dialogue_balloon(dialogueIndex, "start") # Starts Dialogue

func _on_done_talking() -> void:
	print("I'm done being talked to!")
	if inCombat == true:
		return
	elif self.is_in_group("Enemy") && inCombat == false:
		Global.combat_start.emit(name)
		inCombat = true
		return
	elif !self.is_in_group("Enemy") && self.is_in_group("NPC"):
		player.dialogue_status.emit()
		$Area2D.monitoring = true # Allows player to talk to npc again



func _on_area_2d_body_entered(body: Node2D, extra_arg_0: NodePath) -> void:
	pass # Replace with function body.
