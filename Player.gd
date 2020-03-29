extends KinematicBody2D

export var acceleration: float = 50
export var friction: float = 100
export var max_speed: float = 200
var velocity: Vector2 = Vector2.ZERO

func _physics_process(delta: float):
  movement_process(delta)

func movement_process(delta: float):
  var up = Input.is_action_pressed("ui_up")
  var down = Input.is_action_pressed("ui_down")
  var left = Input.is_action_pressed("ui_left")
  var right = Input.is_action_pressed("ui_right")

  var direction: Vector2 = Vector2(
    int(right) - int(left),
    int(down) - int(up)
  ).normalized()

  if (direction != Vector2.ZERO):
    velocity += direction * acceleration * delta
    velocity = velocity.clamped(max_speed * delta)
  else:
    velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

  move_and_collide(velocity)
