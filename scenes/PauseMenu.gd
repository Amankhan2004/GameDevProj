extends Control

@onready var pause_label = get_node("Label")
@onready var player = get_parent().get_node("Player")  # Reference to the Player node

# Custom variable to track pause state
var is_paused = false

func _ready():
	pause_label.visible = false  # Hide "Paused" text initially

# Function to toggle pause state
func toggle_pause():
	is_paused = !is_paused  # Toggle the is_paused variable
	pause_label.visible = is_paused  # Show or hide "Paused" label

	# Enable or disable player processing
	player.set_physics_process(!is_paused)  # Enable/disable physics processing for the player

# Handle input in _process() instead of _input to capture keys even when "paused"
func _process(delta):
	# Check for pause toggle with Esc
	if Input.is_action_just_pressed("ui_cancel") and !is_paused:
		toggle_pause()
	# Check for resume with R when paused
	elif Input.is_action_just_pressed("ui_accept") and is_paused:
		toggle_pause()
