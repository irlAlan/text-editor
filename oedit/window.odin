package tedit

import rl "vendor:raylib"


Window :: struct {
	width:  i32,
	height: i32,
	fps:    i32,
  backCol: rl.Color,
  title: cstring,
}

CreateWindow :: proc(win := Window{100,100,60,rl.BEIGE,"DEFAULT"}){
  rl.InitWindow(win.width, win.height,win.title);
  rl.SetTargetFPS(win.fps);
}

CloseWindow :: proc(){
  rl.CloseWindow();
}
