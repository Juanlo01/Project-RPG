extends CharacterBody2D

@onready var npc

@export var dialogueIndex : DialogueResource

#STATIC TYPING
@export var player_WalkSpeed : int = 200
@export var player_RunSpeed  : int = 300
@export var onArea           : bool = false
@export var canMove          : bool = true
@export var onDialogue       : bool = false
@export var onMenu           : bool = false

signal dialogue_status
signal area_entered
signal area_exited
signal npc_name

func get_input(): # For player movement
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if canMove:
		if Input.is_action_pressed("run"):
			velocity = input_direction * player_RunSpeed
		else:
			velocity = input_direction * player_WalkSpeed
	else:
		velocity = input_direction * 0


func _input(event: InputEvent): # BI function called on any Input Event
	if event.is_action_pressed("interact") && onArea == true && onMenu == false && onDialogue == false && canMove: # Currently just triggers dialogue
		npc.talking.emit()
		canMove = !canMove
		onDialogue = !onDialogue

	if event.is_action_pressed("menu") && onDialogue == false: # Opens Menu
		Global.my_menu.emit()
		canMove = !canMove
		onMenu = !onMenu

func _on_area_2d_body_entered(body: Node2D, extra_arg_0: NodePath) -> void: # When player enters NPC Area
	npc = get_node(extra_arg_0)
	onArea = true
	print("Inside range")
	print(npc)
	if npc.is_in_group("Enemy") && !npc.is_in_group("NPC"):
		Global.combat_start.emit(npc.name)
	elif npc.is_in_group("Enemy") && npc.is_in_group("NPC"):
		npc.talking.emit()
		canMove = !canMove
		

func _on_area_2d_body_exited(body: Node2D) -> void:
	onArea = false
	print("Outside range")
	print(npc)

func _on_dialogue_status() -> void: # Global signals player when they are no longer in dialogue
	onDialogue = !onDialogue
	canMove = !canMove
	print("dialogue ended, player is no longer on dialogue")

func _physics_process(_delta): # Function called each Tick
	get_input()
	move_and_slide() # Allows body to slide along other bodies

func _ready():
	process_mode = Node.ProcessMode.PROCESS_MODE_ALWAYS
