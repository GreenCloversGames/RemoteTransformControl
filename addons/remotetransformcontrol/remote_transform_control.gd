extends Control
## A node that follows a point in a 2D or 3D scene to allow you to have it in a seperate canvas layer.
## Instead of linking directly to the node, instead add a marker above/near the node and connect this instead. 
## It will make it easier to edit where you want the control node to appear.

## The path to the node that the Control node will follow.
## This must be a Node2D or Node3D derived class. 
@export var node_path : NodePath:
	set(value):
		await tree_entered
		node_path = value
		node = get_node(node_path)
		if node is Node2D:
			is_3D = false
		elif node is Node3D:
			is_3D = true
		else:
			push_error("Error: Node must derive Node2D or Node3D")

## Set the anchor mode as the same from Camera2D, either from the top_left or from the center of the position
@export var anchor_mode:Camera2D.AnchorMode = Camera2D.ANCHOR_MODE_DRAG_CENTER

## Stores the node that the control node is following.
var node : Node 

## Stores if the node that is being followed is 3D or not. 
var is_3D := false

func _ready():
	pass # Replace with function body.

func _process(delta):
	if node:
		var top_left_pos:Vector2 = get_node_viewport_position()
		if anchor_mode == Camera2D.ANCHOR_MODE_FIXED_TOP_LEFT:
			global_position = top_left_pos
		elif anchor_mode == Camera2D.ANCHOR_MODE_DRAG_CENTER:
			global_position = top_left_pos - get_rect().size/2
	pass

## Gets the screen position of the node, either in 2D or 3D
func get_node_viewport_position():
	var screen_pos := Vector2.ZERO
	if is_3D:
		node = node as Node3D
		var camera = node.get_viewport().get_camera_3d()
		screen_pos = camera.unproject_position(node.global_position)
	else:
		node= node as Node2D
		screen_pos = node.get_global_transform_with_canvas().origin
	return screen_pos
