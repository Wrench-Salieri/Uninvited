extends Node2D

func _ready():
	if GameState.restore_player_position:
		var player = get_tree().get_first_node_in_group("player")

		if player != null:
			player.global_position = GameState.return_position
			GameState.restore_player_position = false
