extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":  # Ensure only the player collects the coin
		body.increment_coin_count()  # Notify the player script
		queue_free()  # Remove the coin from the scene
