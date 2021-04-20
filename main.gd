extends Node2D

var t := 0.0
var curseur_duration_max := 10.5
var curseur_duration_min := 10.0
var jauge_height := 30.0
var jauge_height_ok := 25.0
var d := 0.0
var off := false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t += delta
	var cd = ($player.position.y / 135.0) * (curseur_duration_max - curseur_duration_min) + curseur_duration_min
	d = fmod(t, cd) / cd
	$curseur.position.y = $jauge.position.y - jauge_height / 2 + jauge_height * d

func _input(event):
	if event.is_action_pressed("ui_select") and not off:
		t = 0
		if d >= jauge_height_ok / jauge_height:
			print('ok')
			$player.position.y -= 20.0
			if $player.position.y <= $end.position.y:
				$gg.visible = true
				off = true
		else:
			$player.position.y += 30.0
			if $player.position.y >= 135:
				$perdu.visible = true
				off = true
	if event.is_action_pressed("ui_cancel") and off:
				$gg.visible = false
				$perdu.visible = false
				off = false
				$player.position.y = 135.0 - 15.0
