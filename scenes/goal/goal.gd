class_name Goal
extends Area2D

signal player_scored(player)

func _on_body_entered(body: Node2D) -> void:
	if body is Ball:
		if sign(body.get_direction().x) == 1:
			player_scored.emit(Player.Players.ONE)
		else:
			player_scored.emit(Player.Players.TWO)
