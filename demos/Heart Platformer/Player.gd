extends KinematicBody2D


const ACCELARATION = 512
const MAX_SPEED = 64
const FRICTION = 0.25
const AIR_RESISTANCE = 0.02
const GRAVITY = 200
const JUMP_FORCE = 128

onready var player = $Sprite
onready var animation = $AnimationPlayer

var motion = Vector2()	# Vector2.ZERO

func _physics_process(delta):
	
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if x_input != 0:
		animation.play("run")
		motion.x += x_input * ACCELARATION * delta
		motion.x	 = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
	else:
		animation.play("stand")
		motion.x = lerp(motion.x, 0, FRICTION)
		
	motion.y += GRAVITY * delta
	
	
	motion = move_and_slide(motion, Vector2.UP)
	
	player.flip_h = x_input < 0
	
	if is_on_floor():
		
		if x_input == 0:
			motion.x = lerp(motion.x, 0, FRICTION)
		
		if Input.is_action_just_pressed("ui_up"):
			animation.play("jump")
			motion.y = -JUMP_FORCE
		
		
	else:
		animation.play("jump")
		if x_input == 0:			
				motion.x = lerp(motion.x, 0, AIR_RESISTANCE)
	pass
