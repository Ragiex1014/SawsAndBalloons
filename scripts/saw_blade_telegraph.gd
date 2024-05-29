extends Node2D

const SAWSCENE = preload("res://scenes/saw_blade.tscn")

@onready var arrow_sprite_2d : Sprite2D = $ArrowSprite2D
@onready var timer : Timer = $Timer


var direction = Vector2.RIGHT.rotated(randf_range(0,TAU))

# Called when the node enters the scene tree for the first time.
func _ready():
	arrow_sprite_2d.rotation = direction.angle()
	timer.timeout.connect(_on_timer_timeout)
	Events.balloon_popped.connect(timer.stop)



func _on_timer_timeout():
	Events.saw_blade_added.emit()
	var saw = SAWSCENE.instantiate()
	saw.position = position
	saw.linear_velocity = direction * 50
	get_tree().current_scene.add_child(saw)
	queue_free()
