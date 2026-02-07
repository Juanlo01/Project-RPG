extends Control

func _ready():
	$Control.grab_focus.call_deferred()
