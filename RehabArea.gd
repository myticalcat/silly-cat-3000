extends TextureRect

var posXorigin
var posSadCat
@export var sadcat : SadCat
@export var sadCatProfile : Array[SadCatResouce]
@export var notif : AudioStreamPlayer2D
var sadCatScene = preload("res://rehab/SadCat.tscn")
var level = 0
var currentSadCat = null

func _ready():
	posXorigin = position.x
	position.x += 500
	posSadCat = sadcat.position
	sadcat.queue_free()
	sadcat = null

func _on_cat_rehab_upgrade_open_rehab():
	var tween = create_tween()
	tween.tween_property(self, 'position:x', posXorigin, 0.5).set_ease(Tween.EASE_OUT)


func _on_timer_timeout():
	var rng = randi_range(0, 150)
	print("RehabRNG : " + str(rng))
	if(level * 10 > rng):
		spawn_cat_in_rehab()
		notif.play()

func spawn_cat_in_rehab():
	if currentSadCat != null:
		return
	var sadcat_instance : SadCat = sadCatScene.instantiate()
	sadcat_instance.setSadCat(sadCatProfile.pick_random())
	sadcat_instance.rehabLevel = level
	currentSadCat = sadcat_instance
	add_child(sadcat_instance)
	sadcat_instance.position = posSadCat
	sadcat_instance.position.y += 500
	var tween = create_tween()
	tween.tween_property(sadcat_instance, 'position', posSadCat - Vector2(0, 100), 2).set_ease(Tween.EASE_OUT)
