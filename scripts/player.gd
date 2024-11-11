extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

var coin_count = 0
var target_coin_count = 5  # Number of coins needed for the "next level" message


func _physics_process(delta: float) -> void:
	# Basic physics for gravity and movement
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func increment_coin_count():
	coin_count += 1
	if coin_count >= target_coin_count:
		show_next_level_prompt()

func show_next_level_prompt():
	print("Ready to go to the next level!")
	
	
