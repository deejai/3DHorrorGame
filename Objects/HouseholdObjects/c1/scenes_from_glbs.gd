@tool
extends EditorScript

const GLTF_FOLDERS_PATH = "res://3D_Imports/HouseholdObjects/c1/"
const OUTPUT_SCENES_PATH = "res://Objects/HouseholdObjects/c1/"

func _run():
    import_gltf_scenes()

func import_gltf_scenes():
    var dir = DirAccess.open(GLTF_FOLDERS_PATH)
    if dir:
        var subdirectories = dir.get_directories()
        for subdir in subdirectories:
            var glb_file_path = GLTF_FOLDERS_PATH + "/" + subdir + "/" + subdir + ".glb"
            var loaded_scene = load(glb_file_path)
            if loaded_scene:
                var instance = loaded_scene.instantiate()
                var new_packed_scene = PackedScene.new()
                new_packed_scene.pack(instance)
                var tscn_file_path = OUTPUT_SCENES_PATH + "/" + subdir + "/" + subdir + ".tscn"
                print(instance)
                ResourceSaver.save(new_packed_scene, tscn_file_path)
                print("Created .tscn file for: " + subdir)
            else:
                print("Failed to load .glb file for: " + subdir)
    else:
        print("Failed to open the main directory.")
