extends Control

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	#Global.add_score()
	$Label.text = "Thanks for playing!"
	#$Scores.text = "High scores:\n"
	#for score in Global.scores:
	#$Scores.text = $Scores.text + str(score["score"]) + "\n"


func _on_play_again_pressed():
	get_tree().change_scene_to_file("res://game.tscn")


func _on_quit_pressed():
	get_tree().quit()
