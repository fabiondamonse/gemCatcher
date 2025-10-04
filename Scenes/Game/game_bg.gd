extends Node2D

const GEM = preload("uid://uyqw1u30qffg")
const MARGIN: float = 50
const EXPLODE = preload("uid://dsb4xleejwahp")

@onready var spawnTimer: Timer = $timer
@onready var paddle: Area2D = $Paddle
@onready var scoreSound: AudioStreamPlayer2D = $scoreSound
@onready var backgroundSound: AudioStreamPlayer = $backgroundSound

func spawnGem() -> void:
	var newGem: Gem = GEM.instantiate()
	var x_pos: float = randf_range(get_viewport_rect().position.x + MARGIN, get_viewport_rect().end.x - MARGIN)
	newGem.position = Vector2(x_pos, -MARGIN)
	newGem.gemOffScreen.connect(_onGemOffScreen)
	add_child(newGem)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawnGem()

func stopAll() -> void:
	backgroundSound.stop()
	backgroundSound.stream = EXPLODE
	backgroundSound.play()
	spawnTimer.stop()
	paddle.set_process(false)
	for child in get_children():
		if child is Gem:
			child.set_process(false)

func _on_paddle_area_entered(area: Area2D) -> void:
	print("collission", area)
	if scoreSound.playing == false:
		scoreSound.position = area.position
		scoreSound.play()

func _onGemOffScreen() -> void:
	stopAll()

func _on_timer_timeout() -> void:
	spawnGem()
