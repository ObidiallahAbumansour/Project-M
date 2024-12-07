extends CharacterBody2D

const SPEED = 200
const JUMP_VELOCITY = -350

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


@onready var sprite = $AnimatedSprite2D

func player_direction(direction):
		#changes direction of char
	if direction > 0:
		sprite.flip_h = false
		#attacks_hitbox.scale.x = 1
	elif direction < 0:
		sprite.flip_h = true
		#attacks_hitbox.scale.x = -1

func _physics_process(delta):
	var direction = Input.get_axis("left","right")
	
	#makes spirte turn
	player_direction(direction)
	
	#pulls player to the ground
	if not is_on_floor():
		velocity.y += (gravity * 1.25) * delta
	
	#player movement
	if is_on_floor():
		if !velocity:
			sprite.play("default")
		else:
			sprite.play("walk")
	#elif !is_on_floor():
	#	sprite.play("Jump")
	
	velocity.x = direction * SPEED
	
	move_and_slide()
