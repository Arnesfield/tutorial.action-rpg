extends KinematicBody2D

export var velocity: int = 140
var direction: Vector2 = Vector2.ZERO

func _physics_process(delta: float):
  movement_process(delta)

func movement_process(delta: float):
  var up = Input.is_action_pressed("ui_up")
  var down = Input.is_action_pressed("ui_down")
  var left = Input.is_action_pressed("ui_left")
  var right = Input.is_action_pressed("ui_right")

  direction = Vector2(int(right) - int(left), int(down) - int(up))
  var move: Vector2 = direction.normalized() * velocity * delta

  move_and_collide(move)
