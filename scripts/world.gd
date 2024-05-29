extends Node2D


const sawBladeTelegraphScene = preload("res://scenes/saw_blade_telegraph.tscn")
@onready var timer : Timer = $Timer
@onready var spawn_zone : ColorRect = $SpawnZone
@onready var saw_count_label : Label = $SawCountLabel

var sawCount = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_zone.hide()
	timer.timeout.connect(_on_timer_timeout)
	Events.balloon_popped.connect(timer.stop)
	Events.saw_blade_added.connect(update_saw_count)
	spawnSawBlades()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_timer_timeout():
	spawnSawBlades()

func spawnSawBlades():
	var saw_blade_telegraph = sawBladeTelegraphScene.instantiate()
	var rect = spawn_zone.get_global_rect()
	var saw_x = randf_range(rect.position.x, rect.end.x)
	var saw_y = randf_range(rect.position.y, rect.end.y)
	saw_blade_telegraph.position = Vector2(saw_x , saw_y)
	add_child(saw_blade_telegraph)
	
func update_saw_count():
	sawCount = sawCount + 1
	saw_count_label.text = "Blades\n" + str(sawCount)
