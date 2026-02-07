extends Node2D

@export var Garry:  CharacterBody2D
@export var Garry2: CharacterBody2D

func _ready():
	print(Garry)

func _physics_process(_delta: float):
	pass

func _on_global_my_signal() -> void:
	pass # Replace with function body.
