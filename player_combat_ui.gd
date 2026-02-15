extends PanelContainer

signal focus

@onready var button: Button = %Bash

func _on_focus() -> void:
	button.grab_focus.call_deferred()
