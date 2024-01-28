extends Sprite2D


class_name AutoSilly

@export var notSilly : Texture2D
@export var silly : Texture2D

var manager : Manager

func _ready():
	manager = get_node("/root/Manager")
	scale = Vector2(0.25, 0.25)
	
	
func _on_timer_timeout():
	self.texture = silly
	manager.add_counter(manager.perClick)
	await get_tree().create_timer(0.2).timeout
	self.texture = notSilly


