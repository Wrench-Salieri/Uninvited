
extends Node

var door_unlocked: bool = false
var door_unlocked_inside: bool = false
var previous_scene_path: String = ""
var return_position: Vector2 = Vector2.ZERO
var restore_player_position: bool = false

func return_to_previous_scene():
	restore_player_position = true

	var tree = get_tree()
	var error = tree.change_scene_to_file(previous_scene_path)

	if error != OK:
		print("Failed to load previous scene: ", error)
		return

	await tree.scene_changed

	if not restore_player_position:
		return

	var player = tree.current_scene.get_node_or_null("Player")

	if player != null:
		player.global_position = return_position
		restore_player_position = false
		print("Player position restored: ", return_position)
	else:
		print("Player not found in the returned scene.")
