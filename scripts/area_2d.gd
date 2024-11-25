extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":  # Ensure only the player collects the coin
		var audio_player = $AudioStreamPlayer2D  # Reference the AudioStreamPlayer2D node
		audio_player.play()  # Play the sound effect
		await get_tree().create_timer(0.1).timeout  # Delay the queue_free slightly
		body.increment_coin_count()  # Notify the player script
		queue_free()  # Remove the coin from the scene
