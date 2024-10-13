extends Polygon2D

const SPEED := Vector2(300.0, 700.0)
const POSSIBLE_X_DIRECTIONS := [0.0, 1.0, -1.0, -0.5, 0.5]
const LIFETIME := 5.0

onready var velocity := Vector2(
	POSSIBLE_X_DIRECTIONS[randi()%POSSIBLE_X_DIRECTIONS.size()] * SPEED.x,
	rand_range(0.9, 1.1) * SPEED.y
)

func _ready() -> void:
	$Timer.wait_time = LIFETIME
	$Timer.start()

func _process(delta: float) -> void:
	position += velocity

func _on_Timer_timeout() -> void:
	pass # Replace with function body.
