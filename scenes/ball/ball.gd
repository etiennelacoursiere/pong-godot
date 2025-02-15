class_name Ball
extends CharacterBody2D

@onready var game: Game = $".."
@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D

@export var initial_speed: float = 120
var _speed: float = initial_speed

var _viewport_size: Vector2
var _height: float
var _width: float
var _direction: Vector2

func _ready() -> void:
	_viewport_size = get_viewport_rect().size
	_height = collision_shape_2d.shape.get_rect().size.y
	_width = collision_shape_2d.shape.get_rect().size.x
	reset_ball()

func _process(delta: float) -> void:
	if game.state == game.States.PLAYING:
		if !visible:
			visible = true

		var colision: KinematicCollision2D = move_and_collide(_direction * _speed * delta)
		if colision:
			_direction = _direction.bounce(colision.get_normal())
			_speed += 10
	elif game.state == game.States.PLAYER_SCORED:
		visible = false
		reset_ball()

func reset_ball() -> void:
	_speed = initial_speed
	_direction.x = [-1, 1].pick_random()
	_direction.y = randf_range(-0.5, 0.5)
	_direction = _direction.normalized()
	position.x = _viewport_size.x / 2 - _width / 2
	position.y = _viewport_size.y / 2 - _height / 2
		
func get_direction() -> Vector2:
	return _direction
	
