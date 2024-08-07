extends Node
class_name Walker

const DIRECTIONS = [Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN]

var position = Vector2.ZERO
var direction = Vector2.RIGHT
var borders = Rect2()
var strict_borders = Rect2()
var step_history = []
var steps_since_turn = 0
var rooms = []

@export var min_room_size: int = 2
@export var max_room_size: int = 4

#var rng

func _init(starting_position, new_borders, new_strict_borders):
	#rng = RandomNumberGenerator.new()
	#rng.seed = 5242243038083382028
	position = Vector2.ZERO
	direction = Vector2.RIGHT
	step_history = []
	steps_since_turn = 0
	rooms = []
	assert(new_borders.has_point(starting_position))
	position = starting_position
	step_history.append(position)
	borders = new_borders
	strict_borders = new_strict_borders

func walk(steps):
	place_room(position)
	for step in steps:
		if steps_since_turn >= 6:
			change_direction()
		
		if step():
			step_history.append(position)
		else:
			change_direction()
	return step_history

func step():
	var target_position = position + direction
	if borders.has_point(target_position):
		steps_since_turn += 1
		position = target_position
		return true
	else:
		return false

#func shuffle_array(array: Array):
	#var n = array.size()
	#while n > 1:
		#n -= 1
		#var k = rng.randf_range(0, n)
		#k = int(k)
		#var temp = array[n]
		#array[n] = array[k]
		#array[k] = temp

func change_direction():
	place_room(position)
	steps_since_turn = 0
	var directions = DIRECTIONS.duplicate()
	directions.erase(direction)
	directions.erase(-direction)
	directions.shuffle()
	#shuffle_array(directions)
	direction = directions.pop_front()
	while not borders.has_point(position + direction):
		direction = directions.pop_front()

func create_room(position, size):
	return {position = position, size = size}

func place_room(position):
	var size = Vector2(randi() % (max_room_size - min_room_size) + min_room_size, randi() % (max_room_size - min_room_size) + min_room_size)
	var top_left_corner = (position - size/2).ceil()
	for y in size.y:
		for x in size.x:
			var new_step = top_left_corner + Vector2(x, y)
			if strict_borders.has_point(new_step):
				step_history.append(new_step)
	rooms.append(create_room(position, size))

func get_end_room():
	var end_room = rooms.pop_front()
	var starting_position = step_history.front()
	for room in rooms:
		if starting_position.distance_to(room.position) > starting_position.distance_to(end_room.position):
			end_room = room
	return end_room

func get_player_room_position():
	return step_history.front()
