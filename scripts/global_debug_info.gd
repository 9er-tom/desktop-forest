extends Node

var debugInfoEnabled := true
signal debug_info_toggled(toggled_on: bool)

func toggleDebugInfo(toggled_on: bool = !debugInfoEnabled):
	debugInfoEnabled = toggled_on
	debug_info_toggled.emit(toggled_on)
