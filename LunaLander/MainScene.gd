extends Node2D

const SCREEN_HEIGHT = 640
const ACCEL_GY = 1.0		# 重力加速度
const ACCEL_IY = 5.0		# メインエンジン噴射加速度
const FULL_FUEL = 5000		# 燃料量初期値
const CONSUMPTION = 10		# メインエンジン噴射燃料消費量
const LANDING_MAX_SPEED = 5.0	# 着陸許容速度

var velocity = Vector2(0, 10)
var fuel = FULL_FUEL# 燃料残量

var Explosion = load("res://Explosion.tscn")

func updateFuel():
	$InfoBar/FuelLabel.text = "FUEL: %d" % fuel
func _ready():
	updateFuel()
	pass # Replace with function body.

func _physics_process(delta):
	velocity += Vector2(0, ACCEL_GY)*delta
	if( Input.is_action_pressed("ui_up") &&		# ↑キー押下時
		fuel >= CONSUMPTION && !$LunaModule.is_on_floor()):		# 燃料あり && 着陸していない
			fuel -= CONSUMPTION
			updateFuel()
			velocity -= Vector2(0, ACCEL_IY)*delta
			$LunaModule/AnimatedSprite.play("injection")
	else:
		$LunaModule/AnimatedSprite.play("default")
	var v0 = velocity
	velocity = $LunaModule.move_and_slide(velocity, Vector2.UP)
	$InfoBar/SpeedLabel.text = "Speed: %.3f, %.3f" % [velocity.x, velocity.y]
	$InfoBar/PosLabel.text = "Pos: %.3f, %.3f" % [$LunaModule.position.x, SCREEN_HEIGHT - $LunaModule.position.y]
	#print($LunaModule.is_on_floor())
	if $LunaModule.is_on_floor() && v0.y >= LANDING_MAX_SPEED:
		$LunaModule.hide()
		var ex = Explosion.instance()
		ex.position = $LunaModule.position
		add_child(ex)
		ex.restart()


func _on_1RoundButton_pressed():
	pass # Replace with function body.
