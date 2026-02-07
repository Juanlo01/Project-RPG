extends CharacterBody2D

@export var dialogueIndex : DialogueResource = load("res://New.dialogue")
@onready var player = get_node("/root/Main/Player")

signal talking
signal done_talking

func _physics_process(_delta):
	pass

func _on_area_2d_area_entered(area: Area2D):
	#print(name) # Replace with function body.
	#Global.my_npc.emit(name)
	print("my name is " + name)

func _on_talking() -> void:
	print("I'm being talked to!")
	$GarryArea.monitoring = false
	DialogueManager.show_dialogue_balloon(dialogueIndex, "start")
	#Global.my_signal.emit(dialogueIndex)

func _on_done_talking() -> void:
	print("I'm done being talked to!")
	$GarryArea.monitoring = true


func _on_garry_area_body_entered(body: Node2D) -> void:
	if body != self || body != get_parent():
		print("Player Entered Area")
		var npc = name
		player.area_entered.emit(npc)
		Global.my_npc.emit(npc)


func _on_garry_area_body_exited(body: Node2D) -> void:
	if body != self || body != get_parent():
		print("Player Left Area")
		player.area_exited.emit()
