extends Sprite2D


class_name GatoGacha

var notSilly : Texture2D
var silly : Texture2D
@export var timer : Timer
var amountClick : int
var explosion = preload("res://assets/SillyCatExplosion.tscn")
@export var commonSilly : Array[GatoResorce]
@export var rareSilly : Array[GatoResorce]
@export var superSilly : Array[GatoResorce]
@export var cSfx : AudioStreamPlayer2D
@export var rSfx : AudioStreamPlayer2D
@export var sSfx : AudioStreamPlayer2D
var manager : Manager


func _ready():
	
	randomize()
	manager = get_node("/root/Manager")
	var gachaResult : GatoResorce = getGatoRandom()
	notSilly = gachaResult.spriteOff
	silly = gachaResult.spriteOn
	texture = notSilly
	timer.wait_time = gachaResult.speedClick
	amountClick = gachaResult.clickAmount
	manager.add_cat(gachaResult)
	match gachaResult.rarity :
		0 :
			cSfx.play()
			rSfx.queue_free()
			sSfx.queue_free()
			spawn_floating_text("Common Gato.", Color.GREEN)
			cSfx.finished.connect(cSfx.queue_free)
		1 : 
			cSfx.queue_free()
			rSfx.play()
			sSfx.queue_free()
			spawn_floating_text("Rare Gato!", Color.GOLD, 200)
			rSfx.finished.connect(rSfx.queue_free)
		2 : 
			cSfx.queue_free()
			rSfx.queue_free()
			sSfx.play()
			spawn_floating_text("SSR GATO!!1", Color.GOLD, 500, true)
			sSfx.finished.connect(sSfx.queue_free)
			
	scale = Vector2(0.25, 0.25)

func getGatoRandom() -> GatoResorce:
	var num = randi_range(0, 100)
	if num > 95:
		return superSilly.pick_random()
	if num > 50:
		return rareSilly.pick_random()
	return commonSilly.pick_random()
	

func _on_timer_timeout():
	self.texture = silly
	manager.add_counter(amountClick)
	await get_tree().create_timer(0.2).timeout
	self.texture = notSilly

func spawn_floating_text(text: String, color: Color, fontsize = 100, isSsr = false) -> void:
	var label = Label.new()
	label.text = text
	label.add_theme_font_size_override('font_size', fontsize)

	label.modulate = color
	add_child(label)
	label.position = Vector2(randi_range(-500, 0), 0)
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(label, "position", label.position + Vector2(0, -300), 2)
	tween.tween_property(label, "modulate:a", 0, 2)

	if isSsr:
		var colors = [Color.RED, Color.ORANGE, Color.YELLOW, Color.GREEN, 
					  Color.BLUE, Color.INDIGO, Color.VIOLET]
		var i = 0
		while true:
			if (label.modulate.a < 0.1):
				label.queue_free()
				return
			if (i == colors.size()):
				i = 0
			var c = colors[i]
			label.modulate = c
			i += 1
			await get_tree().create_timer(0.1).timeout
	await get_tree().create_timer(2).timeout
	label.queue_free()

func spawn_particle_explosion() -> void:
	var explosion_instance : GPUParticles2D = explosion.instantiate()
	add_child(explosion_instance)
	explosion_instance.emitting = true
	explosion_instance.one_shot = true
