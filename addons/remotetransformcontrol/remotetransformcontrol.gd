@tool
extends EditorPlugin


func _enter_tree():
	# Initialization of the plugin goes here.
	add_custom_type(
		"RemoteTransformControl", 
		"Control", 
		preload("res://addons/remotetransformcontrol/remote_transform_control.gd"), 
		preload("res://addons/remotetransformcontrol/RemoteTransformControl.svg")
	)
	pass


func _exit_tree():
	# Clean-up of the plugin goes here.
	remove_custom_type("RemoteControlNode")
	pass
