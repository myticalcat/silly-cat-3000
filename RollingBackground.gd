extends TextureRect

var speed = 50
func _process(delta):
	position.x -= delta * speed
	if(position.x <= -1500):
		position.x = 0
