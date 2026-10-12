extends Area2D

var entered = false

func _on_body_entered(body: CharacterBody2D):
	entered = true


func _on_body_exited(body: CharacterBody2D):
	entered = false

func _process(delta):
	if entered and Input.is_action_just_pressed("ui_interact"):
		print("The door is locked!")
