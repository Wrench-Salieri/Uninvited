extends CharacterBody2D

@export var speed = 100
@export var gravity = 200
@export var jump_height = -100
@export var coyote_time: float = 0.1
@export var jump_buffer_time: float = 0.1
@export var next_to_stair = false

var coyote_timer: float = 0.0
var jump_buffer_timer: float = 0.0
var is_special_action = false


#movement and physics
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		coyote_timer -= delta
	else:
		coyote_timer = coyote_time

	# vertical movement processing (up)
	if Input.is_action_just_pressed("ui_jump") and is_on_floor():
		velocity.y = jump_height
		coyote_timer = 0.0
		if velocity.y > 0:
			velocity += gravity * delta * 1.5
	
	# horizontal movement processing (left, right)
	var direction := Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * speed
	#applies movement
	move_and_slide() 
	if !is_special_action:
		player_animation()
	if direction and velocity.y >=0.0:
		next_to_stair = not %DetectWall.is_colliding() and %DetectStair.is_colliding()
		$AutoClimb.disabled = not next_to_stair

func player_animation():
	# for left
	if Input.is_action_pressed("ui_left") || Input.is_action_just_released("ui_jump") and is_on_floor():
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("walk")
	# for left
	if Input.is_action_pressed("ui_right") || Input.is_action_just_released("ui_jump") and is_on_floor():
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("walk")
	# idle
	if !Input.is_anything_pressed():
		$AnimatedSprite2D.play("idle")	
	
func _input(event):
	if event.is_action_pressed("ui_attack"):
		is_special_action = true
		$AnimatedSprite2D.play("attack")
	
	if event.is_action_pressed("ui_jump") and is_on_floor():
		is_special_action = true
		velocity.y = jump_height
		velocity.x = speed
		$AnimatedSprite2D.play("jump")
		$AutoClimb.disabled = true
	else:
		gravity = 200
	
	#if next_to_stair == true:
		#is_special_action = true
		#$AnimatedSprite2D.play("climb_stairs")
	#else:
		#is_special_action = false
		
func _on_animated_sprite_2d_animation_finished():
	is_special_action = false
