extends Control

var indicator_margin = Vector2(25, 25)
var indicator_index = 25
var Indicator = load("res://UI/Indicator.tscn")
var indicator_scale = Vector2(0.5,0.5)
var indicator_scale_start = Vector2(0.5,0.5)
var indicator_scale_target = Vector2(1.5,1.5)
var indicator_mod = 0.0
var indicator_mod_start = 0.0
var indicator_mod_target = 0.5


func _ready():
	update_score()
	update_time()
	update_lives()
	update_fever()
	


func update_score():
	$Score.text = "Score: " + str(Global.score)

func update_time():
	$Time.text = "Time: " + str(Global.time)

func update_lives():
	var indicator_pos = Vector2(indicator_margin.x, Global.VP.y - indicator_margin.y)
	for i in $Indicator_Container.get_children():
		i.queue_free()
	for i in range(Global.lives):
		var indicator = Indicator.instantiate()
		indicator.position = Vector2(indicator_pos.x + i*indicator_index, indicator_pos.y)
		$Indicator_Container.add_child(indicator)

func update_fever():
	$Fever.value = Global.fever

func breathe():
	indicator_scale = indicator_scale_target if indicator_scale == indicator_scale_start else indicator_scale_start
	indicator_mod = indicator_mod_target if indicator_mod == indicator_mod_start else indicator_mod_start

func _on_Timer_timeout():
	Global.update_time(-1)
