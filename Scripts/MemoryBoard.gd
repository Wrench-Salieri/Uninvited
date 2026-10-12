
extends Node2D

var first_card = null
var second_card = null
var checking: bool = false
var matched_pairs: int = 0

var total_pairs: int = 0

func _ready():
	var cards = find_children("*", "Area2D", true, false)
	total_pairs = int(cards.size() / 2)

	print("Cards found: ", cards.size())

	for card in cards:
		print("Connecting signal for: ", card.name)
		card.pressed.connect(_on_card_pressed)

func _on_card_pressed(card):
	if checking:
		return

	if card.matched or card.revealed:
		return

	card.reveal()

	if first_card == null:
		first_card = card
		return

	second_card = card
	checking = true

	await get_tree().create_timer(0.8).timeout

	if first_card.pair_id == second_card.pair_id:
		first_card.mark_matched()
		second_card.mark_matched()
		matched_pairs += 1
	else:
		first_card.hide_card()
		second_card.hide_card()

	first_card = null
	second_card = null
	checking = false
	
	if matched_pairs == total_pairs:
		GameState.door_unlocked_inside = true
		print("The door has been unlocked!")

		GameState.return_to_previous_scene()
