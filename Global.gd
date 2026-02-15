extends Node

# @export allows its modding on the inspector
@onready var menu  : CenterContainer = get_node("/root/Global/Menu")
@onready var combat_ui : CenterContainer = get_node("/root/Global/Combat_UI")
@onready var player_combat_ui : PanelContainer = get_node("/root/Global/Player_Combat_UI")
@onready var enemy_name = $"%Label"
@onready var player = get_node("/root/Main/Player")

var combat_scene = preload("res://Combat.tscn")
var combat_instance = combat_scene.instantiate()

signal my_npc
signal my_menu
signal combat_start

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

func _on_combat_start(enemy_name):
	get_tree().current_scene.call_deferred("add_child", combat_instance) # Adds Combat scene to current scene
	combat_ui.visible = !combat_ui.visible
	player_combat_ui.visible = !player_combat_ui.visible
	player_combat_ui.grab_focus.call_deferred()
	player_combat_ui.focus.emit()
	%Label.text = enemy_name

func _ready(): # Called when Game Starts
	#my_signal.connect(_on_my_signal) # N/A
	my_npc.connect(_on_my_npc)
	my_menu.connect(_on_my_menu)
	combat_start.connect(_on_combat_start)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	
	
