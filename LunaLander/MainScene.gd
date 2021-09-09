extends Node2D

const SCREEN_HEIGHT = 640
const ACCEL_GY = 1.0		# 重力加速度

var velocity = Vector2(0, 10)

var Explosion = load("res://Explosion.tscn")

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	velocity += Vector2(0, ACCEL_GY)*delta
	var v0 = velocity
	velocity = $LunaModule.move_and_slide(velocity, Vector2.UP)
	$InfoBar/SpeedLabel.text = "Speed: %.3f, %.3f" % [velocity.x, velocity.y]
	$InfoBar/PosLabel.text = "Pos: %.3f, %.3f" % [$LunaModule.position.x, SCREEN_HEIGHT - $LunaModule.position.y]
	#print($LunaModule.is_on_floor())
	if $LunaModule.is_on_floor() && v0.y >= 10:
		$LunaModule.hide()
		var ex = Explosion.instance()
		ex.position = $LunaModule.position
		add_child(ex)
		ex.restart()
