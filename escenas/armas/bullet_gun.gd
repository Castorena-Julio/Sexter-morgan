extends Area2D


const speed : int = 200


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _process(delta: float) -> void:
	position +=  transform.x * speed * delta


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	queue_free()
