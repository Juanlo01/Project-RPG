extends Node

# @export allows its modding on the inspector
@onready var menu  : CenterContainer = get_node("/root/Main/Menu")
@onready var player = get_node("/root/Main/Player")

signal my_npc
signal my_menu

var onDialogue = false
var npcName

func _on_my_npc(extra_arg_0: NodePath) -> void: # When player enters NPC Area
	print("-----------------")
	print(extra_arg_0)
	npcName = get_node(extra_arg_0)

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
	npcName.done_talking.emit()
	

func _ready(): # Called when Game Starts
	#my_signal.connect(_on_my_signal) # N/A
	my_npc.connect(_on_my_npc)
	my_menu.connect(_on_my_menu)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	
	
