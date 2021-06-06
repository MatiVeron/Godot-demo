extends KinematicBody2D


# Declare member variables here. Examples:
var speed = 260
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_movimiento_pj()

	position += velocity * delta

	position.x = clamp(position.x, 50, 970)
	position.y = clamp(position.y, 530, 588)

	_animacion_pj()

func _movimiento_pj():
	velocity = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		velocity.x = 1
	if Input.is_action_pressed("ui_left"):
		velocity.x = -1
	if Input.is_action_pressed("ui_up"):
		velocity.y = -1
	if Input.is_action_pressed("ui_down"):
		velocity.y = 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	# Funcion para modificar las animaciones
func _animacion_pj():
	if velocity.length() != 0:
		$AnimatedSprite.play("Caminar")
		if velocity.x < 0:
			$AnimatedSprite.flip_h = true
		else:
			$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.play("Idle")


