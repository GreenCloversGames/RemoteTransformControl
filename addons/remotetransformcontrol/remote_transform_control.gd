extends Control

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

@export var anchor_mode:Camera2D.AnchorMode = Camera2D.ANCHOR_MODE_DRAG_CENTER
var node : Node 
var is_3D := false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if node:
		var top_left_pos:Vector2 = get_node_viewport_position()
		if anchor_mode == Camera2D.ANCHOR_MODE_FIXED_TOP_LEFT:
			global_position = top_left_pos
		elif anchor_mode == Camera2D.ANCHOR_MODE_DRAG_CENTER:
			global_position = top_left_pos - get_rect().size/2
	pass

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
