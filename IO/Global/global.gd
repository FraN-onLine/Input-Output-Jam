extends Node

var Good_Points = 0
var current_day = 1

# Ghost status: true = that character found peace and stops appearing
var student_rested = false
var kid_rested = false
var karen_rested = false
var worker_rested = false

# Ghost permanently gone (only appears if NOT resting from previous day)
var student_done = false
var kid_done = false
var karen_done = false