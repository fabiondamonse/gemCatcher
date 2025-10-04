extends Area2D

const SPEED:float = 380.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var leftXEdge:float = get_viewport_rect().position.x
	var rightXEdge:float = get_viewport_rect().end.x
	var movement: float = SPEED * delta * Input.get_axis("moveLeft", "moveRight")
	
	position.x = clampf((position.x + movement), leftXEdge, rightXEdge)


func _on_area_entered(area: Area2D) -> void:
	print("collision detected on padel")
