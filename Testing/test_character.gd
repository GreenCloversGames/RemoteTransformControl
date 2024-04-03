extends CharacterBody2D

@export var speed:float
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = Vector2.ZERO
	var actions = ["ui_right", "ui_down", "ui_left", "ui_up"]
	for i in range(len(actions)):
		var action = actions[i]
		if Input.is_action_pressed(action):
			print(action)
			velocity += Vector2.RIGHT.rotated((PI/2) * i)
	velocity = velocity.normalized()*speed
	move_and_slide()
	pass
