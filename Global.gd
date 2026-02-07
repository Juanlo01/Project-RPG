extends Node


# onready waits until those nodes are loaded to use them
@onready var menu = get_node("/root/Main/Menu")
@onready var player = get_node("/root/Main/Player")
@onready var resource = load("res://First.dialogue")
@onready var resource2 = load("res://Second.dialogue")
@export var Garry : CharacterBody2D



signal my_npc
signal my_menu


var onDialogue = false

var library : Array[DialogueResource] = [resource, resource2]
var npcName


func _on_my_npc(name):
	print("-----------------")
	print(name)
	npcName = get_node(NodePath("/root/Main/" + name))
	#get_node(NodePath(name))
	player.npc_name.emit("/root/Main/" + name)
	
func _input(event: InputEvent): # Function called on any Input Event
	#print("Input")
	pass

func _on_my_menu():
	menu.visible = !menu.visible
	menu.grab_focus.call_deferred()
	menu.focus.emit()

func _on_dialogue_started(_dialogue):
	print("Started")
	onDialogue = true

func _on_dialogue_ended(_dialogue):
	print("Ended")
	onDialogue = false
	player.dialogue_status.emit()
	npcName.done_talking.emit()
	

func _ready(): # Called when Game Starts
	#my_signal.connect(_on_my_signal) # N/A
	my_npc.connect(_on_my_npc)
	my_menu.connect(_on_my_menu)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	
	
