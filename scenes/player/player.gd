class_name Player
extends StaticBody2D

enum Players {ONE, TWO}
@export var player: Players
@export var speed: float = 100
@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D

var _viewport_size: Vector2
var _paddle_height: float
var _paddle_width: float
var _direction: float

func _ready() -> void:
	_viewport_size = get_viewport_rect().size
	_paddle_height = collision_shape_2d.shape.get_rect().size.y
	_paddle_width = collision_shape_2d.shape.get_rect().size.x
	set_initial_position()


func _process(delta: float) -> void:
	if player == Players.ONE:
		_direction = Input.get_axis("player_one_down", "player_one_up")
	elif player == Players.TWO:
		_direction = Input.get_axis("player_two_down", "player_two_up")

	position.y -= _direction * speed * delta
	position.y = clamp(position.y, 0, _viewport_size.y - _paddle_height)

func set_initial_position() -> void:
	position.y = _viewport_size.y / 2 - _paddle_height / 2
	
	if player == Players.ONE:
		position.x = 5
	elif player == Players.TWO:
		position.x = _viewport_size.x - _paddle_width - 5
	else:
		push_error("No player set")
