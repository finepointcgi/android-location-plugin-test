extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var singleton

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().connect("on_request_permissions_result", self, "result")
	print("getting premission!")
	
	if(OS.request_permissions()):
		print("requested premissions successful!")
	result("", true)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func result(permission, granted):
	if granted:
		print("granted looking for plugin")
		if Engine.get_singleton("LocationPlugin"):
			print("found plugin")
			singleton = Engine.get_singleton("LocationPlugin")
			singleton.connect("onLocationUpdates", self, "gotLocationUpdate")
			singleton.connect("onLastKnownLocation", self, "gotLastKnown")
			singleton.connect("onLocationError", self, "gotLocationError")
			
func gotLocationUpdate(locData):
	$VBoxContainer2/Longitude.text = str(locData.longitude)
	$VBoxContainer2/Latitude.text = str(locData.latitude)
	$VBoxContainer2/Accuracy.text = str(locData.accuracy)
	$VBoxContainer2/altitude.text = str(locData.altitude)
	
func gotLastKnown(locData):
	gotLocationUpdate(locData)
	
func gotLocationError(error, message):
	print(error, message)


func _on_Button_button_down():
	singleton.getLastKnowLocation()
	pass # Replace with function body.
