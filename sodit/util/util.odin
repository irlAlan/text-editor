package util

import "core:c"

Vec2i :: struct {
	x, y: c.int,
}

Dim :: struct {
	width, height: c.int,
}

Col :: struct {
  r,g,b,a: u8,
}
