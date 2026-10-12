extends Area2D

var entered = false

@onready var locked_sound: AudioStreamPlayer2D = $LockedSound
@onready var open_sound: AudioStreamPlayer2D = $OpenSound

func _on_body_entered(body: CharacterBody2D):
	entered = true


func _on_body_exited(body: CharacterBody2D):
	entered = false

func _process(delta):
	if entered and Input.is_action_just_pressed("ui_interact"):
		if GameState.door_unlocked:
			open_sound.play()
			get_tree().change_scene_to_file("res://Scenes/Inside.tscn")
		else:
			locked_sound.play()
			print("The door is locked!")
