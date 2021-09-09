extends Node2D

const ACCEL_GY = 0.2		# 重力加速度

var velocity = Vector2(0, 10)

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	velocity += Vector2(0, ACCEL_GY)
	velocity = $LunaModule.move_and_slide(velocity)
