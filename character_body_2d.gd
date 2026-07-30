extends CharacterBody2D

@export var can_move = true
const SPEED = 150.0
const JUMP_VELOCITY = -250.0
var flip : bool = false
@onready var iRay = $InteractionRange

func _ready() -> void:
	$"?".visible = false



func _physics_process(delta: float) -> void:
	$Sprite2D.flip_h = flip
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if can_move:
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		if Input.is_action_just_released("ui_accept") and velocity.y < 0:
			velocity.y = JUMP_VELOCITY / 4


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if can_move:
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		if direction == 1:
			flip = false
			iRay.target_position.x = 10
		elif direction == -1:
			flip = true
			iRay.target_position.x = -10
	
	if Input.is_action_just_pressed("Interaction"):
		if iRay.is_colliding():
			var obj = iRay.get_collider()
			if obj.has_method("interact"):
				obj.interact()
			else:
				What()
		else:
			What()
		
	move_and_slide()

func What():
	if is_on_floor():
		$"?".visible = true
		$"?".play("default")

func dontmove():
	can_move = false

func move():
	can_move = true


func _on__animation_finished() -> void:
	$"?".visible = false
