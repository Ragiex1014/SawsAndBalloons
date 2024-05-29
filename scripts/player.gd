extends CharacterBody2D

const MAX_SPEED = 100
const ACCEL = 1000
const FRICTION = 100

var input = Vector2.ZERO

@onready var hurtbox : Area2D = $Hurtbox

func _ready():
	hurtbox.body_entered.connect(_on_hurtbox_body_entered)
func get_input():
	var input_vector = Input.get_vector("ui_left", "ui_right" ,"ui_up", "ui_down").normalized()
	return input_vector

func player_movement(delta):
	input = get_input()
	
	if input == Vector2.ZERO:
		if velocity.length() > (FRICTION * delta):
			velocity -= velocity.normalized() * (FRICTION * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (input * ACCEL * delta)
		velocity = velocity.limit_length(MAX_SPEED)
	
	move_and_slide()
	

func  _physics_process(delta):
	player_movement(delta)

func _on_hurtbox_body_entered(_body):
	Events.balloon_popped.emit()
	queue_free()
	
 
