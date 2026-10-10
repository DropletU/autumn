class_name PlayerState extends Node

var player: Player

@warning_ignore("unused_signal")
signal transition(new_state: String)

func enter(): pass
func exit(): pass
func physics_update(_delta: float): pass
func unhandled_input(_event: InputEvent): pass
