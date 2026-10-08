extends CharacterBody2D


@export var speed = 100
@export var gravity = 200
@export var jump_height = -100

var is_attacking = false
var is_climbing = false

#movement and physics
func _physics_process(delta):
	# vertical movement velocity (down)
	velocity.y += gravity * delta
	# horizontal movement processing (left, right)
	horizontal_movement()
	#applies movement
	move_and_slide() 
	var direction := Input.get_axis("ui_left", "ui_right")
	if !is_attacking:
		player_animation()
		
	if direction and velocity.y >=0.0:
		var next_to_stair = not %DetectWall.is_colliding() and %DetectStair.is_colliding()
		$AutoClimb.disabled = not next_to_stair
	
func horizontal_movement():
	# if keys are pressed it will return 1 for ui_right, -1 for ui_left, and 0 for neither
	var horizontal_input = Input.get_action_strength("ui_right") -  Input.get_action_strength("ui_left")
	# horizontal velocity which moves player left or right based on input
	velocity.x = horizontal_input * speed

func player_animation():
	# for left
	if Input.is_action_pressed("ui_left") || Input.is_action_just_released("ui_jump"):
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("walk")
	# for left
	if Input.is_action_pressed("ui_right") || Input.is_action_just_released("ui_jump"):
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("walk")
	# idle
	if !Input.is_anything_pressed():
		$AnimatedSprite2D.play("idle")	
	
func _input(event):
	if event.is_action_pressed("ui_attack"):
		is_attacking = true
		$AnimatedSprite2D.play("attack")
	
	if event.is_action_pressed("ui_jump") and is_on_floor():
		velocity.y = jump_height
		$AnimatedSprite2D.play("jump")
		$AutoClimb.disabled = true
	
	if is_climbing == true:
		if event.is_action_pressed("ui_up"):
			$AnimatedSprite2D.play("climb")
			gravity = 100
			velocity.y = -200
	else:
		gravity = 200
		is_climbing = false	
		
func _on_animated_sprite_2d_animation_finished():
	is_attacking = false
	is_climbing = false
