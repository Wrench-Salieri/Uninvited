
extends Area2D

signal pressed(card)

@export var pair_id: int = 0
@export var front_texture: Texture2D
@export var back_texture: Texture2D

@onready var sprite: Sprite2D = $Sprite2D

var revealed: bool = false
var matched: bool = false


func _ready():
	input_pickable = true
	sprite.texture = back_texture

	print("Card ready: ", name)
	print("Back texture assigned: ", back_texture != null)


func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("Card clicked: ", name)
			pressed.emit(self)


func reveal():
	revealed = true
	sprite.texture = front_texture
	print("Revealed card: ", name)


func hide_card():
	revealed = false
	sprite.texture = back_texture


func mark_matched():
	matched = true
