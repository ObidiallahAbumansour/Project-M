extends CharacterBody2D

@onready var facing_dir = $RayCast2D
@onready var animated_sprite = $AnimatedSprite2D


const SPEED = 100

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var current_attack = false
var direction = 1

func _physics_process(delta):
	
	#direction
	if facing_dir.is_colliding():
		direction *= -1
		facing_dir.scale.y *= -1
		if animated_sprite.flip_h == true:
			animated_sprite.flip_h = false
		else:
			animated_sprite.flip_h = true
	
	#non-attack moves
	if is_on_floor() :
		if !velocity:
			animated_sprite.play("default")
		else:
			animated_sprite.play("walk")
	elif !is_on_floor():
		velocity.y += gravity * delta
	
	velocity.x = direction * SPEED
	
	move_and_slide()
