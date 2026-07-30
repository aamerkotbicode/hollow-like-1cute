extends Node2D
@export var tip_pressed = Texture2D
@export var tip_depressed = Texture2D
@export var pos : Vector2
func _ready():
	$pop.visible = false


func _process(delta):
	$Camera2D.position.x = $Player.position.x - 150
	if Input.is_action_pressed("ui_accept"):
		$Tip.texture = tip_pressed
	else:
		$Tip.texture = tip_depressed
	if Input.is_action_just_pressed("ui_accept"):
		$pop.visible = true
		$pop.play("pop")
	pos = $Player.position


func _on_pop_animation_finished():
	$pop.visible = false
