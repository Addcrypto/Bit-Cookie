extends Camera2D

# This script is supposed to automatically set the camera boundaries
# so the player can never see beyond the borders of the level, but it doesn't
# work very well
# TODO: Investigate better method of doing above

# TODO: This is nasty garbage
onready var tile_map = get_tree().get_root().get_node("Root").get_node("Navigation2D").get_node("TileMap")

# Set the boundaries of the camera to the edges of the tilemap, so it can't
# scroll beyond the level
func _ready():
   # assert(tile_map != null, "Could not find TileMap in scene root");

    var map_limits = tile_map.get_used_rect()
    var map_cellsize = tile_map.cell_size
 
    set_limit(MARGIN_LEFT, map_limits.position.x * map_cellsize.x)
    set_limit(MARGIN_RIGHT, map_limits.end.x * map_cellsize.x)
    set_limit(MARGIN_TOP, map_limits.position.y * map_cellsize.y)
    set_limit(MARGIN_BOTTOM, map_limits.end.y * map_cellsize.y)
