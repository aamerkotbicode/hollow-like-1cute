extends Node2D
@onready var opacity = $Sprite2D.self_modulate.a
@onready var playername = "Player"
@onready var playerpos = get_parent().pos
@onready var scroll = $firescroll
var scrollspin = false
func _ready() -> void:
	scroll.visible = false
func _process(delta: float) -> void:
	if scrollspin:
		scroll.play("idle")
		opacity = position.distance_to(playerpos) - 200
	print(position.distance_to(playerpos))


func _on_area_2d_body_entered(body: Node2D):
	
	if body.name == playername:
		if !scrollspin:
			scroll.play("open")
		scroll.visible = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == playername:
		scroll.visible = false
	


func _on_firescroll_animation_finished() -> void:
	scrollspin = true
