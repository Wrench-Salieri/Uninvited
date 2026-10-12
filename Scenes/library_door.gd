extends Sprite2D

@onready var interactable = $Interactable

var unlocked: bool = false

func _ready() -> void:
	interactable.interact = _on_interact

func _on_interact() -> void:
	if unlocked:
		print("The door is already unlocked!")
		return

	var panel = get_tree().current_scene.get_node_or_null("CanvasLayer/CodePanel")

	if panel:
		panel.visible = true
		panel.get_node("CodeInput").text = ""
		panel.get_node("CodeInput").grab_focus()
	else:
		print("CodePanel not found!")
