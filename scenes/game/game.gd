class_name Game
extends Node2D
@onready var goal_one: Goal = %Goal
@onready var goal_two: Goal = %Goal2
@onready var score_player_one_label: Label = %ScorePlayer1
@onready var score_player_two_label: Label = %ScorePlayer2
@onready var prompt_label: Label = %PromptLabel

enum States {
	READY,
	PLAYING,
	PLAYER_SCORED,
}

var state: States

var score_player_one: int = 0
var score_player_two: int = 0

func _ready() -> void:
	goal_one.player_scored.connect(_on_player_scored)
	goal_two.player_scored.connect(_on_player_scored)
	
	state = States.READY
	
	prompt_label.text = "Press space to serve!"

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("reset_ball"):
		prompt_label.visible = false
		state = States.PLAYING
	
func _on_player_scored(player: Player.Players):
	state = States.PLAYER_SCORED
	
	if player == Player.Players.ONE:
		score_player_one += 1
		score_player_one_label.text = str(score_player_one)
		prompt_label.text = "Player one scored!\nPress space to serve!"
		prompt_label.visible = true
	elif player == Player.Players.TWO:
		score_player_two += 1
		score_player_two_label.text = str(score_player_two)
		prompt_label.text = "Player two scored!\nPress space to serve!"
		prompt_label.visible = true
