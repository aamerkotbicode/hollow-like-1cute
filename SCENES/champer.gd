extends Node2D
@onready var playername = "Player"
@onready var scroll = $firescroll
var scrollspin = false
@onready var parentnode = get_tree().get_first_node_in_group("firescroll")
@export var duration := 1.0


@onready var labelarea: Area2D = $Area2D2
@onready var label: Label = $Area2D2/fontlabel


func _ready() -> void:
	scroll.visible = false
	label.visible_characters = 0


func _process(delta: float) -> void:
	if parentnode:
		var playerpos = parentnode.pos
	if scrollspin:
		scroll.play("idle")
		$firescroll.self_modulate.a = position.distance_to(parentnode.pos)
	if $interactspace.lit:
		$Area2D2.visible = false
		$firescroll.visible = false
		if $Light.texture_scale < 4:
			$Light.texture_scale += 0.01



func _on_area_2d_body_entered(body: Node2D):
	
	if body.name == playername:
		if !scrollspin:
			scroll.play("open")
		if !$interactspace.lit:
			scroll.visible = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == playername:
		scroll.visible = false
	


func _on_firescroll_animation_finished() -> void:
	scrollspin = true

func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.name == playername:
		label.visible_characters = 0
		var tween = create_tween()
		tween.tween_property(label, "visible_characters", label.text.length(), duration)
