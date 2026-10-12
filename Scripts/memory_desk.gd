extends StaticBody2D

@onready var interactable: Area2D = $Interactable

func _ready() -> void:
	interactable.interact = _on_interact

func _on_interact():
	var player = get_node_or_null("../Player")

	if player == null:
		print("Player not found!")
		return

	GameState.previous_scene_path = get_tree().current_scene.scene_file_path
	GameState.return_position = player.global_position

	get_tree().change_scene_to_file("res://Scenes/Memory_Quiz.tscn")
