extends CenterContainer

signal focus

@onready var button: Button = $PanelContainer/VBoxContainer/Button

func _ready():
	#button.focus_mode = Control.FOCUS_ALL
	pass
	


func _on_focus() -> void:
	button.grab_focus.call_deferred()
