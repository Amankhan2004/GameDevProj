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
		var jump_audio = $AudioStreamPlayer2D
		jump_audio.play()

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func increment_coin_count():
	coin_count += 1
	if coin_count >= target_coin_count:
		trigger_video()

func trigger_video():
	print("Playing triggered video!")
	# Reference the CanvasLayer and VideoStreamPlayer
	var video_canvas = get_parent().get_node("CanvasLayer")  # Correct node name
	var video_player = video_canvas.get_node("VideoStreamPlayer")
	
	# Hide other game elements
	hide_all_game_elements()

	# Make the video fullscreen
	video_player.set_position(Vector2(0, 0))  # Position at the top-left corner
	video_player.set_size(get_viewport_rect().size)  # Resize to match the viewport size
	video_player.visible = true  # Show the VideoPlayer
	video_player.play()  # Play the video

func _on_VideoStreamPlayer_finished() -> void:
	# Reference the CanvasLayer
	var video_canvas = get_parent().get_node("CanvasLayer")
	var video_player = video_canvas.get_node("VideoStreamPlayer")
	
	# Hide the VideoPlayer after playback
	video_player.visible = false
	
	# Restore game elements
	show_all_game_elements()

func hide_all_game_elements():
	# Hide all relevant nodes (e.g., Player, PauseMenu, TileMap)
	get_parent().get_node("Player").hide()
	get_parent().get_node("PauseMenu").hide()
	get_parent().get_node("TileMap").hide()

func show_all_game_elements():
	# Show all previously hidden nodes
	get_parent().get_node("Player").show()
	get_parent().get_node("PauseMenu").show()
	get_parent().get_node("TileMap").show()
