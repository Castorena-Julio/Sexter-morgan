extends Area2D

var direccion: Vector2 = Vector2.RIGHT
var velocidad: float = 500.0

func _ready():
	# Conectar señal para destruirse al chocar con un cuerpo sólido
	body_entered.connect(_on_body_entered)

func _physics_process(delta):
	position += direccion * velocidad * delta

func _on_body_entered(_body: Node2D) -> void:
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
