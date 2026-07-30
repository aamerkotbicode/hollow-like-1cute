extends Area2D
var lit = false
func _ready() -> void:
	$fire.visible = false
func interact():
	if !lit:
		lit = true
		print("fire!")
		var player = get_tree().get_first_node_in_group("player")
		player.dontmove()
		$fire.visible = true
		$fire.play("default")
		await $fire.animation_finished
		player.move()
		idle()
	
	
func idle():
	$fire.play("Idle")
