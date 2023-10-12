extends StaticBody2D

var score = 0
var new_position = Vector2.ZERO
var dying = false
var time_appear = 0.5
var time_fall = 0.8
var time_rotate = 1.0
var time_a = 0.8
var time_s = 1.2
var time_v = 1.5
var tween

var sway_amplitude = 3.0
var sway_initial_position = Vector2.ZERO
var sway_randomizer = Vector2.ZERO

var powerup_prob = 0.1

func _ready():
	randomize()
	position.x = new_position.x
	position.y = -100
	tween = create_tween()
	tween.tween_property(self, "position", new_position, 0.5 + randf()*2).set_trans(Tween.TRANS_BOUNCE)
	sway_initial_position = $Sprite2D.position
	sway_randomizer = Vector2(randf()*6-3.0, randf()*6-3.0)
	
	
func _physics_process(_delta):
	if dying and not $Confetti.emitting and not tween:
		queue_free()
	var pos_x = (sin(Global.sway_index)*(sway_amplitude + sway_randomizer.x))
	var pos_y = (cos(Global.sway_index)*(sway_amplitude + sway_randomizer.y))
	$Sprite2D.position = Vector2(sway_initial_position.x + pos_x, sway_initial_position.y + pos_y)

func hit(_ball):
	die()

func die():
	var Brick_Sound = get_node("/root/Game/Brick_Sound")
	Brick_Sound.play()
	dying = true
	collision_layer = 0
	$Confetti.emitting = true
	Global.update_score(score)
	if not Global.feverish:
		Global.update_fever(score)
	get_parent().check_level()
	if randf() < powerup_prob:
		var Powerup_Container = get_node_or_null("/root/Game/Powerup_Container")
		if Powerup_Container != null:
			var Powerup = load("res://Powerups/Powerup.tscn")
			var powerup = Powerup.instantiate()
			powerup.position = position
			Powerup_Container.call_deferred("add_child", powerup)
	if tween:
		tween.kill()
	tween = create_tween().set_parallel(true)
	tween.tween_property(self, "position", Vector2(position.x, 1000), time_fall).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)
	tween.tween_property(self, "rotation", -PI + randf()*2*PI, time_rotate).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($Sprite2D, "modulate:a", 0, time_a)
	tween.tween_property($Sprite2D, "modulate:s", 0, time_s)
	tween.tween_property($Sprite2D, "modulate:v", 0, time_v)
