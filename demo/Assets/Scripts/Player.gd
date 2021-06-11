extends KinematicBody2D


# Declare member variables here. Examples:
var speed = 260
var velocity = Vector2.ZERO
var corriendo=false
## Variables de correr
var double_tap_right=false
var double_tap_left=false

	
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
		if double_tap_right:
			corriendo=true
		velocity.x = 1
	if Input.is_action_pressed("ui_left"):
		if double_tap_left:
			corriendo=true
		velocity.x = -1
	if Input.is_action_pressed("ui_up"):
		velocity.y = -1
	if Input.is_action_pressed("ui_down"):
		velocity.y = 1
		
	if Input.is_action_just_released("ui_right"):
		double_tap_right=true;
		$Timer.start()
		if corriendo:
			corriendo=false
	if Input.is_action_just_released("ui_left"):
		double_tap_left=true;
		$Timer.start()
		if corriendo:
			corriendo=false
		
	if corriendo:
		speed=500
	else:
		speed=260
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	# Funcion para modificar las animaciones
func _animacion_pj():
	if velocity.length() != 0:
		if !corriendo:
			$AnimatedSprite.play("Caminar")
		else:
			$AnimatedSprite.play("Correr")
		if velocity.x < 0:
			$AnimatedSprite.flip_h = true
		else:
			$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.play("Idle")

###############################




	



func _on_Timer_timeout():
	double_tap_right=false
	double_tap_left=false
