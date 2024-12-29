extends CharacterBody2D

const SPEED = 200
const JUMP_VELOCITY = -350
var enemey_AtckRange = false
var enemy_AtckCooldwon = true
var HEALTH = 100
var player_alive = true
# var zome :=Vector2(2, 2)

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var camera_2d: Camera2D = $Camera2D
@onready var sprite = $AnimatedSprite2D

# player entity  
func player():
	pass
	
	
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
	
	#check if the enemy ready to attack if so the enemy will attack the player
	enemy_attack()
	
	# check if the player is still alive
	# we need to add death sence and motion
	if HEALTH <= 0:
		player_alive = false
		HEALTH = 0 
		get_tree().reload_current_scene()
		# // death_timer.start() -- when the death timer timedout 
		# // we need to run the reload method on to rest the game 
		#camera_2d.set_zoom(zome)
		#Engine.time_scale = 0.3

	
	
	#makes spirte turn
	player_direction(direction)
	
	#pulls player to the ground
	if not is_on_floor():
		velocity.y += (gravity * 1.25) * delta
	
	#makes player jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	
	#player movement
	if is_on_floor():
		if !velocity:
			sprite.play("default")
		else:
			sprite.play("walk")
	elif !is_on_floor():
		sprite.play("jump")
	
	velocity.x = direction * SPEED
	
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	# check if the body enterd the area is enemey 
	if body.has_method("enemy"): 
		enemey_AtckRange = true
		
	

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"): 
		enemey_AtckRange = false
		
#check if the enemy ready to attack if so the enemy will attack the player
func enemy_attack():
	if enemey_AtckRange and enemy_AtckCooldwon:
		HEALTH = HEALTH-5 
		enemy_AtckCooldwon = false
		$attack_cooldown.start()
		print("took damge -5 " , HEALTH)


func _on_attack_cooldown_timeout() -> void:
	enemy_AtckCooldwon = true
	 
# test1 
