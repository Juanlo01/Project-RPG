extends Node2D

@export var player: CharacterBody2D
@export var Garry:  CharacterBody2D
@export var Garry2: CharacterBody2D

func _on_my_npc(npc):
	print("-----------------")
	print(npc)
	player.npc_name.emit()
