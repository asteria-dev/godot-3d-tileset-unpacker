extends Node

@onready var save_path = "res://tilesets/blocks/{str}.tscn"
#This is the inherited scene from the .blend file
#-col suffix allows the .blend file to be imported with collisions
@onready var tileset = load("res://tilesets/building_blks.tscn").instantiate()

func _ready() -> void:
	var scene = PackedScene.new()
	#Loop every block
	for block in tileset.get_children():
		var node = unpack(block, block)
		node.set_position(Vector3.ZERO)
		scene.pack(node)
		ResourceSaver.save(scene, save_path.format({"str": block.name}))
		
func unpack(node : Node3D, parent : Node3D):
	#Recursion to get every children
	#Sets the owner of the child to its parent
	#This allows the node/children to be saved 
	#with its parent in a packed scene
	#Read docu for set_owner
	for _i in node.get_children():
		_i.set_owner(parent)
		unpack(_i, parent)
	return node
