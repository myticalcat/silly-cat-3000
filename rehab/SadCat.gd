extends TextureButton

class_name SadCat

@export var progBar : ProgressBar
@export var dialogueBox : Label
@export var catName : Label
var rehabLevel = 1;

func _on_button_down():
	var manager : Manager = get_tree().get_root().get_children()[0]
	manager.change_main_silly()
	await get_tree().create_timer(0.1).timeout
	manager.change_main_not_silly()
	progBar.value -= randi_range(1,10)
	if(progBar.value <= 0):
		manager.add_counter(randi_range(100, 1000) * rehabLevel)
		destroy()

func destroy():
	var tween = create_tween()
	tween.tween_property(self, 'position:y', 1000, 1).set_ease(Tween.EASE_IN)
	await get_tree().create_timer(1).timeout
	queue_free()

func _on_timer_timeout():
	destroy()

func setSadCat(cat : SadCatResouce):
	catName.text = cat.name.pick_random()
	dialogueBox.text = cat.story.pick_random()
	texture_normal = cat.sadcat
